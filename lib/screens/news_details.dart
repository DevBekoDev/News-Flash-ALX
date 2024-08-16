import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_flash/screens/world_news.dart';

class NewsDetails extends StatefulWidget {
  String data;
  NewsDetails({super.key, required this.data});
  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse(data));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
