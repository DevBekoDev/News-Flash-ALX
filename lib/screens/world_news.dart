import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_flash/models/news_model.dart';

class WorldNews extends StatefulWidget {
  const WorldNews({super.key});

  @override
  State<WorldNews> createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
      future: newsViewModel.fetchNewsHeadlines(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const Column(
              children: [Text("Okay")],
            ),
          );
        } else {
          return const Center(
            child: Text("Error loading news"),
          );
        }
      },
    );
  }
}
