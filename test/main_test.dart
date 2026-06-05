import 'package:evi_example/provider/chat_provider.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:evi_example/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
      'SessionRepository can be downcast to ChatProviderSessionRepository',
      (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatProvider()),
          ChangeNotifierProvider<SessionRepository>(
            create: (_) => ChatProviderSessionRepository(),
          ),
          Provider<SessionService>(
            create: (_) => const SessionService(),
          ),
        ],
        child: _AttachWidget(),
      ),
    );

    await tester.pump();

    expect(find.byType(_AttachWidget), findsOneWidget);
  });
}

class _AttachWidget extends StatefulWidget {
  @override
  State<_AttachWidget> createState() => _AttachWidgetState();
}

class _AttachWidgetState extends State<_AttachWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final repo =
            context.read<SessionRepository>() as ChatProviderSessionRepository;
        final chatProvider = context.read<ChatProvider>();
        repo.attach(chatProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
