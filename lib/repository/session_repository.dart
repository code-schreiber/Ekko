import 'package:flutter/material.dart';
import 'package:evi_example/models/session.dart';
import 'package:evi_example/provider/chat_provider.dart';

abstract class SessionRepository extends ChangeNotifier {
  List<Session> getSessions();
}

class ChatProviderSessionRepository extends ChangeNotifier
    implements SessionRepository {
  ChatProvider? _chatProvider;

  void attach(ChatProvider chatProvider) {
    _chatProvider?.removeListener(notifyListeners);
    _chatProvider = chatProvider;
    _chatProvider!.addListener(notifyListeners);
    notifyListeners();
  }

  @override
  void dispose() {
    _chatProvider?.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  List<Session> getSessions() {
    final chats = _chatProvider?.previousChats ?? [];
    return chats.map((chat) {
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
