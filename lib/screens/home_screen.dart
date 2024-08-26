import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:news_flash/screens/news_category/science_news.dart';
import 'package:news_flash/screens/search_screen.dart';
import 'package:news_flash/screens/settings_screen.dart';
import 'package:news_flash/screens/news_category/sports_news.dart';
import 'package:news_flash/screens/news_category/tech_news.dart';
import 'package:news_flash/screens/news_category/world_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 234, 223),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 199, 193, 174),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color.fromARGB(255, 199, 193, 174),
          ),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            iconSize: 25,
            backgroundColor: const Color.fromARGB(255, 199, 193, 174),
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
                  icon: Icon(CupertinoIcons.lab_flask_solid), label: 'Science'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.device_laptop), label: 'Tech'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          )),
      body: _childeren[currentIndex],
    );
  }
}
