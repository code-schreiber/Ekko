import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:evi_example/chat_card.dart';
import 'package:evi_example/provider/chat_provider.dart';
import 'package:evi_example/utils.dart';
import 'package:evi_example/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../evi_message.dart' as evi;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // define config here for recorder
  final config = RecordConfig(
    encoder: AudioEncoder.pcm16bits,
    bitRate: 48000 *
        2 *
        16, // 48000 samples per second * 2 channels (stereo) * 16 bits per sample
    sampleRate: 48000,
    numChannels: 1,
    autoGain: true,
    echoCancel: true,
    noiseSuppress: true,
  );
  late final int audioInputBufferSize;

  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder audioRecorder = AudioRecorder();
  WebSocketChannel? chatChannel;
  bool isConnected = false;
  var chatEntries = <ChatEntry>[];

  // As EVI speaks, it will send audio segments to be played back. Sometimes a new segment
  // will arrive before the old audio segment has had a chance to finish playing, so -- instead
  // of directly playing an audio segment as it comes back, we queue them up here.
  final List<Source> playbackAudioQueue = [];

  // Holds bytes of audio recorded from the user's microphone.
  List<int> audioInputBuffer = <int>[];

  late VideoPlayerController _videoController;

  // EVI sends back transcripts of both the user's speech and the assistants speech, along
  // with an analysis of the emotional content of the speech. This method takes
  // of a message from EVI, parses it into a `ChatMessage` type and adds it to `chatEntries` so
  // it can be displayed.
  void appendNewChatMessage(evi.ChatMessage chatMessage, evi.Inference models) {
    final role = chatMessage.role == 'assistant' ? Role.assistant : Role.user;
    final entry = ChatEntry(
        role: role,
        timestamp: DateTime.now().toString(),
        content: chatMessage.content,
        scores: CallPage.extractTopThreeEmotions(models));
    setState(() {
      chatEntries.add(entry);
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final connectButton = IconButton(
      onPressed: isConnected ? disconnect : connect,
      icon: Icon(
        Icons.graphic_eq,
        color: isConnected ? Colors.red : Colors.green,
        size: 48,
      ),
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: ChatDisplay(entries: chatEntries)),
                SizedBox(
                  width: 320,
                  height: 250,
                  child: _videoController.value.isInitialized
                      ? VideoPlayer(_videoController)
                      : const Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 120),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[connectButton])),
                const SizedBox(height: 40),
              ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    audioPlayer.dispose();
    audioRecorder.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioInputBufferSize = config.bitRate ~/ 10;
    final AudioContext audioContext = AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playAndRecord,
        options: const {
          AVAudioSessionOptions.defaultToSpeaker,
        },
      ),
      android: AudioContextAndroid(
        isSpeakerphoneOn: true,
        audioMode: AndroidAudioMode.inCommunication,
        stayAwake: true,
        contentType: AndroidContentType.speech,
        usageType: AndroidUsageType.voiceCommunication,
        audioFocus: AndroidAudioFocus.gainTransientExclusive,
      ),
    );
    AudioPlayer.global.setAudioContext(audioContext);
    audioPlayer.onPlayerComplete.listen((event) {
      playNextAudioSegment();
    });

    Provider.of<ChatProvider>(context, listen: false).setContext(context);

    // Initialize video controller with muted audio
    _videoController =
        VideoPlayerController.asset('assets/icons/voice_assistant.mp4')
          ..initialize().then((_) {
            setState(() {});
          })
          ..setLooping(true)
          ..setVolume(0.0);
  }

  // Opens a websocket connection to the EVI API and registers a listener to handle
  // incoming messages.
  void connect() {
    setState(() {
      isConnected = true;
    });
    if (ConfigManager.instance.humeApiKey.isNotEmpty &&
        ConfigManager.instance.humeAccessToken.isNotEmpty) {
      throw Exception(
          'Please use either an API key or an access token, not both');
    }

    var uri = 'wss://api.hume.ai/v0/evi/chat';
    if (ConfigManager.instance.humeAccessToken.isNotEmpty) {
      uri += '?access_token=${ConfigManager.instance.humeAccessToken}';
    } else if (ConfigManager.instance.humeApiKey.isNotEmpty) {
      uri +=
          '?api_key=${AppConfig.humeApiKey}&config_id=REPLACE_THIS_WITH_ACTUAL_HUME_CONFIG_ID';
    } else {
      throw Exception('Please set your Hume API credentials in main.dart');
    }

    chatChannel = WebSocketChannel.connect(Uri.parse(uri));

    chatChannel!.stream.listen(
      (event) async {
        final message = evi.EviMessage.decode(event);
        debugPrint("Received message: ${message.type}");
        // This message contains audio data for playback.
        switch (message) {
          case (evi.ErrorMessage errorMessage):
            debugPrint("Error: ${errorMessage.message}");
            break;
          case (evi.ChatMetadataMessage chatMetadataMessage):
            debugPrint("Chat metadata: ${chatMetadataMessage.rawJson}");
            // ignore: use_build_context_synchronously
            Provider.of<ChatProvider>(context, listen: false)
                .addChat(chatMetadataMessage.rawJson);
            prepareAudioSettings();
            startRecording();
            break;
          case (evi.AudioOutputMessage audioOutputMessage):
            final data = audioOutputMessage.data;
            final rawAudio = base64Decode(data);
            Source source;
            if (!kIsWeb) {
              source = urlSourceFromBytes(rawAudio);
            } else {
              source = BytesSource(rawAudio);
            }

            enqueueAudioSegment(source);
            break;
          case (evi.UserInterruptionMessage _):
            handleInterruption();
            break;
          // These messages contain the transcript text of the user's or the assistant's speech
          // as well as emotional analysis of the speech.
          case (evi.AssistantMessage assistantMessage):
            appendNewChatMessage(
                assistantMessage.message, assistantMessage.models);
            break;
          case (evi.UserMessage userMessage):
            appendNewChatMessage(userMessage.message, userMessage.models);
            handleInterruption();
            break;
          case (evi.UnknownMessage unknownMessage):
            debugPrint("Unknown message: ${unknownMessage.rawJson}");
            break;
        }
      },
      onError: (error) {
        debugPrint("Connection error: $error");
        handleConnectionClosed();
      },
      onDone: () {
        debugPrint("Connection closed");
        handleConnectionClosed();
      },
    );

    debugPrint("Connected");
    _videoController.play();
  }

  void disconnect() {
    handleConnectionClosed();
    handleInterruption();
    chatChannel?.sink.close();
    debugPrint("Disconnected");
    Timer(const Duration(seconds: 6), () {
      Provider.of<ChatProvider>(context, listen: false).postProcessChat();
    });
    _videoController.pause();
  }

  void enqueueAudioSegment(Source audioSegment) {
    debugPrint("Enqueueing audio segment");
    if (!isConnected) {
      return;
    }
    if (audioPlayer.state == PlayerState.playing) {
      playbackAudioQueue.add(audioSegment);
    } else {
      audioPlayer.play(audioSegment);
    }
  }

  void flushAudio() {
    if (audioInputBuffer.isNotEmpty) {
      sendAudio(audioInputBuffer);
      audioInputBuffer.clear();
    }
  }

  void handleConnectionClosed() {
    setState(() {
      isConnected = false;
    });
    audioInputBuffer.clear();
    stopRecording();
  }

  void handleInterruption() {
    playbackAudioQueue.clear();
    audioPlayer.stop();
  }

  void playNextAudioSegment() {
    if (playbackAudioQueue.isNotEmpty) {
      final audioSegment = playbackAudioQueue.removeAt(0);
      audioPlayer.play(audioSegment);
    }
  }

  void prepareAudioSettings() {
    // set session settings to prepare EVI for receiving linear16 encoded audio
    // https://dev.hume.ai/docs/empathic-voice-interface-evi/configuration#session-settings
    chatChannel!.sink.add(jsonEncode({
      'type': 'session_settings',
      'audio': {
        'encoding': 'linear16',
        'sample_rate': 48000,
        'channels': 1,
      },
    }));
  }

  void sendAudio(List<int> audioBytes) {
    final base64 = base64Encode(audioBytes);
    chatChannel!.sink.add(jsonEncode({
      'type': 'audio_input',
      'data': base64,
    }));
  }

  void startRecording() async {
    if (!await audioRecorder.hasPermission()) {
      return;
    }
    final audioStream = await audioRecorder.startStream(config);

    audioStream.listen((data) async {
      audioInputBuffer.addAll(data);

      if (audioInputBuffer.length >= audioInputBufferSize) {
        final bufferWasEmpty = !audioInputBuffer.any((element) => element != 0);
        if (bufferWasEmpty) {
          audioInputBuffer = [];
          return;
        }
        sendAudio(audioInputBuffer);
        audioInputBuffer = [];
      }
    });
    audioStream.handleError((error) {
      debugPrint("Error recording audio: $error");
    });
  }

  void stopRecording() {
    audioRecorder.stop();
  }

  // In the `audioplayers` library, iOS does not support playing audio from a `ByteSource` but
  // we can use a `UrlSource` with a data URL.
  UrlSource urlSourceFromBytes(List<int> bytes,
      {String mimeType = "audio/wav"}) {
    return UrlSource(Uri.dataFromBytes(bytes, mimeType: mimeType).toString());
  }
}
