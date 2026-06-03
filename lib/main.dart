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
        ProxyProvider<ChatProvider, SessionRepository>(
          update: (_, chatProvider, __) =>
              ChatProviderSessionRepository(chatProvider),
        ),
        Provider<SessionService>(
          create: (_) => const SessionService(),
        ),
      ],
      child: const MyApp(child: NavigationPage()),
    ),
  );
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
    // const SettingsPage(),
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
