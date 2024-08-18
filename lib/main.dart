import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:news_flash/screens/home_screen.dart';
import 'package:news_flash/screens/science_news.dart';
import 'package:news_flash/screens/search_screen.dart';
import 'package:news_flash/screens/sports_news.dart';
import 'package:news_flash/screens/world_news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final List<Widget> _childeren = [
    const WorldNews(),
    const SportsNews(),
    const ScienceNews()
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
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
