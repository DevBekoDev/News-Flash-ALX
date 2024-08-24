import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news_flash/comp/NewsList.dart';
import 'package:news_flash/constants/constants.dart';
import 'package:news_flash/models/news_model.dart';

class TechNews extends StatefulWidget {
  const TechNews({super.key});

  @override
  State<TechNews> createState() => _TechNewsState();
}

class _TechNewsState extends State<TechNews> {
  NewsViewModel newsViewModel = NewsViewModel();
  Future<NewsModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/everything?q=tech&language=$NEWS_LANGUAGE&apikey=$NEWS_API_KEY';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsModel.fromJson(body);
    }
    throw Exception('Error');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
      future: fetchNewsHeadlines(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return NewsList(articles: snapshot.data!.articles!.toList());
          } else {
            return const Center(
              child: Text("No news available"),
            );
          }
        } else {
          return const Center(
            child: Text("Error loading news"),
          );
        }
      },
    );
  }
}
