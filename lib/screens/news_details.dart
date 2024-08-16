import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  String data;
  String title;
  NewsDetails({super.key, required this.data, required this.title});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details News'),
      ),
      body: WebView(
        initialUrl: widget.data,
        javascriptMode: JavascriptMode.disabled,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController = webViewController;
        },
      ),
    );
  }
}
