import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_flash/Auth/appwrite/change_language_provider.dart';
import 'package:news_flash/comp/NewsList.dart';
import 'package:news_flash/constants/constants.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ScienceNews extends StatefulWidget {
  const ScienceNews({super.key});

  @override
  State<ScienceNews> createState() => _ScienceNewsState();
}

class _ScienceNewsState extends State<ScienceNews> {
  Future<NewsModel> fetchNewsHeadlines(String language) async {
    String url =
        'https://newsapi.org/v2/everything?q=health&language=$language&apikey=$NEWS_API_KEY';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsModel.fromJson(body);
    }
    throw Exception('Error');
  }

  @override
  Widget build(BuildContext context) {
    final newsLanguageProvider = context.watch<NewsLanguageProvider>();
    return FutureBuilder<NewsModel>(
      future: fetchNewsHeadlines(newsLanguageProvider.newsLanguage),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Color.fromARGB(255, 199, 193, 174),
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
