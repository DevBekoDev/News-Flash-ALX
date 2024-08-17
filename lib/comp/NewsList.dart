import 'package:flutter/material.dart';
import 'package:news_flash/comp/NewsCard.dart';

class NewsList extends StatelessWidget {
  final List articles;

  NewsList({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return NewsCard(
          title: article.title.toString(),
          url: article.url.toString(),
          publishedAt: DateTime.parse(article.publishedAt.toString()),
          imageUrl: article.urlToImage,
        );
      },
    );
  }
}
