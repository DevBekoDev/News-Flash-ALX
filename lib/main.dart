import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/screens/login_screen.dart';
import 'package:news_flash/Auth/screens/signup_screen.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:news_flash/screens/home_screen.dart';
import 'package:news_flash/screens/science_news.dart';
import 'package:news_flash/screens/settings_screen.dart';
import 'package:news_flash/screens/sports_news.dart';
import 'package:news_flash/screens/tech_news.dart';
import 'package:news_flash/screens/world_news.dart';
import 'package:appwrite/appwrite.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthAPI()), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Client client = Client();

  // This widget is the root of your application.
  final List<Widget> _childeren = [
    const WorldNews(),
    const SportsNews(),
    const ScienceNews(),
    const TechNews(),
    const SettingsScreen()
  ];

  NewsViewModel newsViewModel = NewsViewModel();
  int currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    return MaterialApp(
        routes: {
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: value == AuthStatus.uninitialized
            ? const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : value == AuthStatus.authenticated
                ? const HomeScreen()
                : const LoginScreen());
  }
}
