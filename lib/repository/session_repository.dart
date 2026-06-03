import 'package:evi_example/models/session.dart';
import 'package:evi_example/provider/chat_provider.dart';

abstract class SessionRepository {
  List<Session> getSessions();
}

class ChatProviderSessionRepository implements SessionRepository {
  final ChatProvider _chatProvider;

  ChatProviderSessionRepository(this._chatProvider);

  @override
  List<Session> getSessions() {
    return _chatProvider.previousChats.map((chat) {
      return Session(
        chatMessages: List<Map<String, dynamic>>.from(chat['chatMessages']),
        emotions: (chat['emotions'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
        createdAt: chat['createdAt'] as String,
        priority: chat['priority'] as String,
        diga: chat['diga'] as String? ?? '',
        whatWentWell: chat['whatWentWell'] as String? ?? '',
        challenges: chat['challenges'] as String? ?? '',
      );
    }).toList();
  }
}
