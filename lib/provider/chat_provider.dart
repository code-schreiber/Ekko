import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/emotion_page.dart';
import './initial_sessions.dart'; // Add this import

class ChatProvider extends ChangeNotifier {
  static const String PREFS_KEY = 'previous_chat';

  final List<dynamic> _chats = [];
  Map<String, double> emotions = {};
  bool processedChatReady = false;
  BuildContext? _context;

  // Change the field name to reflect it stores all messages
  List<Map<String, dynamic>> _chatMessages = [];
  List<Map<String, dynamic>> get chatMessages => _chatMessages;

  // Add new field for previous chats
  final List<Map<String, dynamic>> _previousChats = initialSessions;
  List<Map<String, dynamic>> get previousChats => _previousChats;

  String whatWentWell = '';
  String challenges = '';
  final String openAiApiKey = 'REPLACE_THIS_WITH_ACTUAL_OPEN_AI_API_KEY'; // Replace with your actual key

  ChatProvider() {
    _loadSavedChats();
  }

  Future<void> _loadSavedChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedChatsJson = prefs.getString(PREFS_KEY);

      if (savedChatsJson != null) {
        final List<dynamic> decodedChats = json.decode(savedChatsJson);
        _previousChats.clear();
        _previousChats.addAll(
            decodedChats.map((chat) => Map<String, dynamic>.from(chat)));
      }
      notifyListeners();
    } catch (e) {
      print('Error loading saved chats: $e');
    }
  }

  Future<void> _saveChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedChats = json.encode(_previousChats);
      await prefs.setString(PREFS_KEY, encodedChats);
    } catch (e) {
      print('Error saving chats: $e');
    }
  }

  void addChat(chat) {
    _chats.add(chat);
    notifyListeners();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<String> _fetchChatMessages(String chatId) async {
    final url = Uri.parse('https://api.hume.ai/v0/evi/chats/$chatId')
        .replace(queryParameters: {
      'page_number': '0',
      'page_size': '100',
      'ascending_order': 'false',
    });

    final response = await http.get(
      url,
      headers: {
        'X-Hume-Api-Key': 'REPLACE_THIS_WITH_ACTUAL_HUME_API_KEY',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }
    return response.body;
  }

  static List<Map<String, dynamic>> filterMessages(String body) {
    final data = json.decode(body);
    final allMessages = data['events_page']
        .map((message) => {
      'role': message['role'],
      'text': message['message_text'],
      'emotion_features': message['emotion_features'],
    })
        .toList()
        .cast<Map<String, dynamic>>();
    print(allMessages);
    // Remove messages from the start until finding one less than 200 characters
    while (allMessages.isNotEmpty &&
        allMessages.first['role'] != 'USER' &&
        allMessages.first['text'] != null &&
        allMessages.first['text'].length > 200) {
      allMessages.removeAt(0);
    }
    return allMessages;
  }

  static Map<String, double> processEmotions(List<Map<String, dynamic>> messages) {
    Map<String, double> allEmotions = {};
    int messageCount = 0;

    for (final message in messages) {
      if (message['emotion_features'] != null) {
        try {
          final emotionFeatures = json.decode(message['emotion_features']);
          if (emotionFeatures != null) {
            emotionFeatures.forEach((emotion, value) {
              if (emotion != null && value != null) {
                allEmotions[emotion] =
                    (allEmotions[emotion] ?? 0.0) + (value ?? 0.0);
              }
            });
            messageCount++;
          }
        } catch (e) {
          print('Error parsing emotion features: $e');
          continue;
        }
      }
    }

    if (messageCount == 0) return {};

    // Calculate averages and sort
    final emotionAverages = allEmotions.map(
      (key, value) => MapEntry(key, value / messageCount),
    );

    final sortedEmotions = emotionAverages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return all emotions instead of just top 6
    return Map.fromEntries(sortedEmotions);
  }

  String _determinePriority(Map<String, double> emotions) {
    // Simple logic to determine priority based on emotion intensities
    double maxIntensity =
        emotions.values.fold(0, (max, value) => value > max ? value : max);
    if (maxIntensity > 0.7) return 'high';
    if (maxIntensity > 0.4) return 'medium';
    return 'low';
  }

  Future<String> _processWhatWentWell(
      List<Map<String, dynamic>> messages) async {
    try {
      // Combine all user messages into a single transcript
      final transcript = messages
          .where((m) => m['role'] == 'USER')
          .map((m) => m['text'])
          .join(' ');

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiApiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'system',
              'content':
                  'Here is the transcript of the call between a therapist and an AI in which the therapist reflects on a therapy session. session: $transcript. Summarize what did go well in the session. Write only 1 sentence.'
            },
          ],
          'temperature': 0.4,
          'max_tokens': 300,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        throw Exception(
            'Failed to get OpenAI response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing what went well: $e');
      return "Unable to process session highlights.";
    }
  }

  Future<String> _processChallenges(List<Map<String, dynamic>> messages) async {
    try {
      final transcript = messages
          .where((m) => m['role'] == 'USER')
          .map((m) => m['text'])
          .join(' ');

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiApiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'system',
              'content':
                  'Here is the transcript of the call between a therapist and an AI in which the therapist reflects on a therapy session. session: $transcript. Summarize what did not go well in the session. Write only 1 sentence.'
            },
          ],
          'temperature': 0.4,
          'max_tokens': 300,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        throw Exception(
            'Failed to get OpenAI response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing challenges: $e');
      return "Unable to process session challenges.";
    }
  }

  Future<bool> postProcessChat() async {
    if (_chats.isEmpty) return false;

    try {
      var chatId = _chats.last['chat_id'];
      final body = await _fetchChatMessages(chatId);
      _chatMessages = filterMessages(body);

      // Process emotions for user messages
      final userMessages = _chatMessages.where((m) => m['role'] == 'USER').toList();
      if (userMessages.isEmpty) {
        print('No user messages found.');
        return false;
      }

      emotions = processEmotions(userMessages);
      whatWentWell = await _processWhatWentWell(userMessages);
      challenges = await _processChallenges(userMessages);

      // Comment out DiGA recommendation
      /*
      final openAiService = OpenAiService(
          apiKey:
              'REPLACE_THIS_WITH_ACTUAL_OPEN_AI_API_KEY_2');
      final digaRecommendation = await openAiService.makeDiGACall({
        'messages': _chatMessages,
      });
      */
      final digaRecommendation = ""; // Add empty string instead

      // Store the processed chat data
      _previousChats.add({
        'chatMessages': _chatMessages,
        'emotions': emotions,
        'createdAt': DateTime.now().toIso8601String(),
        'priority': _determinePriority(emotions),
        'diga': digaRecommendation,
        'whatWentWell': whatWentWell,
        'challenges': challenges,
      });

      // Save to SharedPreferences
      await _saveChats();

      processedChatReady = true;
      notifyListeners();

      // Navigate to EmotionPage when ready
      if (_context != null) {
        Navigator.push(
          _context!,
          MaterialPageRoute(
            builder: (context) => EmotionPage(
              chatMessages: _chatMessages,
              emotions: emotions,
              diga: digaRecommendation,
              whatWentWell: whatWentWell,
              challenges: challenges,
            ),
          ),
        );
      }

      return true;
    } catch (e) {
      print('Error processing chat: $e');
      return false;
    }
  }
}
