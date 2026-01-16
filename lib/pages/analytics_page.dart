import 'dart:convert';

import 'package:evi_example/widgets/radar_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/chat_provider.dart';
import '../config/app_config.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  DateTime selectedDate = DateTime.now().subtract(const Duration(days: 3));
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? lastUpdated;
  List<String> areasForGrowth = [];
  List<String> successStories = [];
  bool showContent = false;
  bool isLoading = false;
  final String openAiApiKey = AppConfig.openAiApiKey;
  List<Map<String, dynamic>> relevantChats = [];

  List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.pink,
  ];

  Color _getRandomColor() {
    return _colors[DateTime.now().microsecond % _colors.length];
  }

  List<String> _parseListResponse(String response) {
    return response
        .split('\n')
        .where((line) => line.trim().startsWith('-') || RegExp(r'^\d+\.').hasMatch(line.trim()))
        .map((line) {
          line = line.trim();
          if (line.startsWith('-')) {
            return line.substring(2).trim();
          } else {
            return line.replaceFirst(RegExp(r'^\d+\.\s*'), '').trim();
          }
        })
        .toList();
  }

  Future<void> fetchAnalytics() async {
    setState(() {
      isLoading = true;
      showContent = true;
      areasForGrowth = ['Loading...'];
      successStories = ['Loading...'];
    });

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    
    // Get all chats after the selected date
    final relevantChats = chatProvider.previousChats.where((chat) {
      final chatDate = DateTime.parse(chat['createdAt']);
      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      return chatDate.isAfter(selectedDateTime);
    }).toList();

    // Combine all chat messages into one transcript
    String combinedTranscript = '';
    for (var chat in relevantChats) {
      List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(chat['chatMessages']);
      for (var message in messages) {
        if (message['role'] == 'USER') {
          combinedTranscript += '${message['text']}\n';
        }
      }
    }

    if (combinedTranscript.isEmpty) {
      setState(() {
        areasForGrowth = ['No sessions found after selected date and time'];
        successStories = ['No sessions found after selected date and time'];
      });
      return;
    }

    try {
      // Get areas for growth
      final growthResponse = await http.post(
        Uri.parse(AppConfig.openAiChatUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiApiKey',
        },
        body: jsonEncode({
          'model': AppConfig.openAiModel,
          'messages': [
            {
              'role': 'system',
              'content': 'List 2 brief areas for therapist improvement from these transcripts. Keep each point to one short sentence. $combinedTranscript'
            },
          ],
          'temperature': 0.4,
          'max_tokens': 300,
        }),
      );

      // Get success stories
      final successResponse = await http.post(
        Uri.parse(AppConfig.openAiChatUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiApiKey',
        },
        body: jsonEncode({
          'model': AppConfig.openAiModel,
          'messages': [
            {
              'role': 'system',
              'content': 'List 2 brief positive outcomes from these transcripts. Keep each point to one short sentence. $combinedTranscript'
            },
          ],
          'temperature': 0.4,
          'max_tokens': 300,
        }),
      );

      if (growthResponse.statusCode == 200 && successResponse.statusCode == 200) {
        var growthData = jsonDecode(growthResponse.body);
        var successData = jsonDecode(successResponse.body);

        setState(() {
          isLoading = false;
          areasForGrowth = _parseListResponse(
              growthData['choices'][0]['message']['content']);
          successStories = _parseListResponse(
              successData['choices'][0]['message']['content']);
        });
      }
    } catch (e) {
      print('Error fetching analytics: $e');
      setState(() {
        isLoading = false;
        areasForGrowth = ['Error processing data'];
        successStories = ['Error processing data'];
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        lastUpdated = null;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        lastUpdated = null;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Analytics', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatDate(selectedDate),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 16),
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => _selectDate(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatTime(selectedTime),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.access_time, size: 16),
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lastUpdated != null 
                                ? 'Last updated: ${lastUpdated.toString().substring(0, 16)}'
                                : 'Not updated yet',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${relevantChats.length} sessions analyzed',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await fetchAnalytics();
                        setState(() {
                          lastUpdated = DateTime.now();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Update'),
                    ),
                  ],
                ),
                if (showContent) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'Prevalent Emotions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  RadarChartWidget(selectedDate: selectedDate, selectedTime: selectedTime),
                  const SizedBox(height: 40),
                  const Text(
                    'Areas for Growth',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      ...areasForGrowth.map((area) => Column(
                        children: [
                          _buildProblemField(
                            area,
                            Icons.warning_amber_rounded,
                            _getRandomColor(),
                          ),
                          const SizedBox(height: 15),
                        ],
                      )).toList(),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Success Stories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      ...successStories.map((success) => Column(
                        children: [
                          _buildProblemField(
                            success,
                            Icons.favorite_outline,
                            _getRandomColor(),
                          ),
                          const SizedBox(height: 15),
                        ],
                      )).toList(),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProblemField(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: color.withOpacity(0.95),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
