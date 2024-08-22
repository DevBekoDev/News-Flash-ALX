import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/screens/login_screen.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:news_flash/screens/home_screen.dart';
import 'package:news_flash/screens/science_news.dart';
import 'package:news_flash/screens/search_screen.dart';
import 'package:news_flash/screens/settings_screen.dart';
import 'package:news_flash/screens/sports_news.dart';
import 'package:news_flash/screens/tech_news.dart';
import 'package:news_flash/screens/world_news.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  final Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('66c4c619000805580048');

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
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
