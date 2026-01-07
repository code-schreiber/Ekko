import 'dart:convert';

import 'package:evi_example/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'evi_message.dart' as evi;

class CallPage  {
  static List<Score> extractTopThreeEmotions(evi.Inference models) {
    // extract emotion scores from the message
    final scores = models.prosody?.scores ?? {};

    // convert the emotions object into an array of key-value pairs
    final scoresArray = scores.entries.toList();

    // sort the array by the values in descending order
    scoresArray.sort((a, b) => b.value.compareTo(a.value));

    // extract the top three emotions and convert them back to an object
    final topThreeEmotions = scoresArray.take(3).map((entry) {
      return Score(emotion: entry.key, score: entry.value);
    }).toList();

    return topThreeEmotions;
  }
}

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();

  String humeApiKey = "";
  String humeAccessToken = "";
  late final String humeConfigId;

  ConfigManager._internal();

  static ConfigManager get instance => _instance;

  // WARNING! For development only. In production, the app should hit your own backend server to get an access token, using "token authentication" (see https://dev.hume.ai/docs/introduction/api-key#token-authentication)
  String fetchHumeApiKey() {
    return dotenv.env['HUME_API_KEY'] ?? "";
  }

  Future<String> fetchAccessToken() async {
    // Make a get request to dotenv.env['MY_SERVER_URL'] to get the access token
    final authUrl = dotenv.env['MY_SERVER_AUTH_URL'];
    if (authUrl == null) {
      throw Exception('Please set MY_SERVER_AUTH_URL in your .env file');
    }
    final url = Uri.parse(authUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['access_token'];
    } else {
      throw Exception('Failed to load access token');
    }
  }

  Future<void> loadConfig() async {
    // Make sure to create a .env file in your root directory which mirrors the .env.example file
    // and add your API key and an optional EVI config ID.
    await dotenv.load();

    // WARNING! For development only.
    humeApiKey = fetchHumeApiKey();

    // Uncomment this to use an access token in production.
    // humeAccessToken = await fetchAccessToken();
    humeConfigId = dotenv.env['HUME_CONFIG_ID'] ?? '';
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
