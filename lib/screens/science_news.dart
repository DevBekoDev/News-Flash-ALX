import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_flash/comp/NewsList.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:http/http.dart' as http;

class ScienceNews extends StatefulWidget {
  const ScienceNews({super.key});

  @override
  State<ScienceNews> createState() => _ScienceNewsState();
}

class _ScienceNewsState extends State<ScienceNews> {
  Future<NewsModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/everything?q=sports&apikey=c5137648dab347eab35d145ebc88e8ad';

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
