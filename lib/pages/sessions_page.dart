import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:evi_example/pages/emotion_page.dart';
import 'package:evi_example/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final sessions = chatProvider.previousChats;

    // Group sessions by date
    final sortedSessions = sessions.toList()
      ..sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));

    // Assign IDs starting from 1 for the oldest session
    for (int i = sortedSessions.length - 1; i >= 0; i--) {
      sortedSessions[i]['sessionId'] = sortedSessions.length - i;
    }

    final groupedSessions = groupBy(sortedSessions, (session) {
      return DateTime.parse(session['createdAt']).toString().split(' ')[0];
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Sessions'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: groupedSessions.length,
          itemBuilder: (context, index) {
            final date = groupedSessions.keys.elementAt(index);
            final dailySessions = groupedSessions[date]!;
            final headerDate = DateTime.parse(date);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    DateFormat('E, MMM d').format(headerDate),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...dailySessions.map((session) {
                  final sessionTime = DateTime.parse(session['createdAt']);
                  final emotions =
                      (session['emotions'] as Map<String, dynamic>).map(
                    (key, value) => MapEntry(key, (value as num).toDouble()),
                  );
                  final topEmotions = emotions.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));
                  final top3Emotions =
                      topEmotions.take(3).map((e) => e.key).join(', ');

                  return GestureDetector(
                    onTap: () {
                      print(
                          const JsonEncoder.withIndent('  ').convert(sessions));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmotionPage(
                            chatMessages: session['chatMessages'],
                            emotions: emotions,
                            diga: session['diga'],
                            whatWentWell: session['whatWentWell'],
                            challenges: session['challenges'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border(
                            bottom: BorderSide(
                              color: _getPriorityColor(session['priority']),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            'Session ${session['sessionId']} at ${DateFormat('HH:mm').format(sessionTime)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            top3Emotions,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
