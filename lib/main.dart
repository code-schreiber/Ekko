import 'package:evi_example/pages/analytics_page.dart';
import 'package:evi_example/pages/my_home_page.dart';
import 'package:evi_example/pages/sessions_page.dart';
import 'package:evi_example/provider/chat_provider.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:evi_example/service/session_service.dart';
import 'package:evi_example/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'widgets/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigManager.instance.loadConfig();

  runApp(
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
      child: const AppRoot(),
    ),
  );
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final repo = context.read<SessionRepository>() as ChatProviderSessionRepository;
        final chatProvider = context.read<ChatProvider>();
        repo.attach(chatProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp(child: NavigationPage());
  }
}

class MyApp extends StatelessWidget {
  final Widget child;
  const MyApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter with EVI',
      home: child,
      showSemanticsDebugger: false,
      theme: appTheme,
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  List<Widget> pages = [
    const MyHomePage(),
    const SessionsPage(),
    const AnalyticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
