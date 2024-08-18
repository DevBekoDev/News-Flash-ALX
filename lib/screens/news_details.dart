import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class NewsDetails extends StatefulWidget {
  String data;
  String title;
  NewsDetails({super.key, required this.data, required this.title});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  // ignore: non_constant_identifier_names
  IconData not_saved = Icons.bookmark_outline;
  IconData saved = Icons.bookmark;
  // ignore: non_constant_identifier_names
  bool save_button_is_clicked = false;
  late WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details News'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  save_button_is_clicked = !save_button_is_clicked;
                });
              },
              icon: Icon((save_button_is_clicked == true) ? saved : not_saved))
        ],
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
