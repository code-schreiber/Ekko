import 'package:evi_example/models/session.dart';
import 'package:evi_example/pages/emotion_page.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:evi_example/service/session_service.dart';
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
    final repository = context.watch<SessionRepository>();
    final sessionService = context.read<SessionService>();
    final sessions = repository.getSessions();
    final groupedSessions = sessionService.getGroupedSessions(sessions);

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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    DateFormat('E, MMM d').format(date),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...dailySessions.map((session) {
                  final sessionId = sessions.indexOf(session) + 1;
                  final sessionTime = DateTime.parse(session.createdAt);
                  final top3Emotions =
                      session.topEmotionNames(3).join(', ');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmotionPage(
                            chatMessages: session.chatMessages,
                            emotions: session.emotions,
                            diga: session.diga,
                            whatWentWell: session.whatWentWell,
                            challenges: session.challenges,
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
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  _getPriorityColor(session.priority),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            'Session $sessionId at ${DateFormat('HH:mm').format(sessionTime)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            top3Emotions,
                            style:
                                const TextStyle(color: Colors.white70),
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
