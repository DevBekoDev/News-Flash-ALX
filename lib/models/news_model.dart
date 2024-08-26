import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsModel({this.status, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class FetchNewsData {
  Future<NewsModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=c5137648dab347eab35d145ebc88e8ad';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<dynamic> filteredArticles = body['articles'].where((article) {
        return article['urlToImage'] != null;
      }).toList();
      body['articles'] = filteredArticles;
      return NewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}

class NewsViewModel {
  final _rep = FetchNewsData();

  Future<NewsModel> fetchNewsHeadlines() async {
    final response = await _rep.fetchNewsHeadlines();
    return response;
  }
}
