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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
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
                  icon: Icon(CupertinoIcons.globe), label: 'World'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.sportscourt_fill), label: 'Sports'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.lab_flask_solid), label: 'Science')
            ],
          ),
          body: _childeren[currentIndex],
        ));
  }
}
