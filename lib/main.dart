import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/screens/science_news.dart';
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
  int currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 25,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 3,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outlined), label: 'World'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.sportscourt), label: 'Graphs'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.t_bubble), label: 'Graphs')
        ],
      ),
      body: _childeren[currentIndex],
    ));
  }
}
