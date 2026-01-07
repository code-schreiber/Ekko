import 'dart:core';

import 'package:flutter/material.dart';

import 'theme.dart';

enum Role { user, assistant }

class Score {
  final String emotion;
  final double score;

  Score({required this.emotion, required this.score});

  Map<String, dynamic> toJson() {
    return {
      'emotion': emotion,
      'score': score,
    };
  }
}

class ChatEntry {
  final Role role;
  final String timestamp;
  final String content;
  final List<Score> scores;

  ChatEntry(
      {required this.role,
      required this.timestamp,
      required this.content,
      required this.scores});
}

class ChatCard extends StatelessWidget {
  final ChatEntry message;
  const ChatCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment = message.role == Role.user
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: message.role == Role.user
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Card(
          elevation: 2,
          color: message.role == Role.user ? accentBlue200 : white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Text(
                  message.content,
                  style: TextStyle(fontSize: 16),
                ),
                // const SizedBox(height: 8),
                // Text(
                //   message.scores
                //       .map((score) =>
                //           "${score.emotion} (${score.score.toStringAsFixed(1)})")
                //       .join(", "),
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: Colors.grey[600],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatDisplay extends StatefulWidget {
  final List<ChatEntry> entries;
  const ChatDisplay({super.key, required this.entries});

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(ChatDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entries.length > oldWidget.entries.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.entries.length,
        itemBuilder: (context, index) {
          return ChatCard(message: widget.entries[index]);
        },
      ),
    );
  }
}
