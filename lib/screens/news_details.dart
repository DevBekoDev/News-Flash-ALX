import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/appwrite/database_api.dart';
import 'package:news_flash/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  final String data;
  final String title;
  final VoidCallback onBookmarkChanged;

  NewsDetails({
    Key? key,
    required this.data,
    required this.title,
    required this.onBookmarkChanged,
  }) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  IconData notSavedIcon = Icons.bookmark_outline;
  IconData savedIcon = Icons.bookmark;
  late bool articleSaved = false;
  late WebViewController webViewController;

  // Database actions
  final _database = DatabaseAPI();

  late List<Document>? bookmarks = [];
  AuthStatus authStatus = AuthStatus.uninitialized;

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    authStatus = appwrite.status;
    loadBookmarks();
    checkInitialBookmarkStatus();
  }

  void loadBookmarks() async {
    final AuthAPI appwrite = context.read<AuthAPI>();
    final String userId = appwrite.currentUser.$id;
    try {
      final value = await _database.getBookmarks(userId: userId);
      setState(() {
        bookmarks = value.documents;
      });
    } catch (e) {
      print(e);
    }
  }

  void checkInitialBookmarkStatus() async {
    bool exists = await checkIfTitleExists(widget.title);
    setState(() {
      articleSaved = exists;
    });
  }

// Add the article data to the bookmarks collection
  Future<void> addBookmark() async {
    final AuthAPI appwrite = context.read<AuthAPI>();
    final String userId = appwrite.currentUser.$id;
    try {
      await _database.addBookmark(
          title: widget.title, url: widget.data, user_id: userId);
      const snackbar = SnackBar(content: Text('Added to Bookmarks!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        articleSaved = true;
      });
      widget.onBookmarkChanged();
      loadBookmarks();
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

// Delete the article data from the bookmarks collection
  Future<void> deleteBookmark(String id) async {
    try {
      await _database.deleteBookmark(id: id);
      setState(() {
        articleSaved = false;
      });
      widget.onBookmarkChanged();
      loadBookmarks();
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

  void showAlert({required String title, required String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

// Check if article title is already saved in the bookmarks
  Future<bool> checkIfTitleExists(String title) async {
    final AuthAPI appwrite = context.read<AuthAPI>();
    final String userId = appwrite.currentUser.$id;
    try {
      final response = await _database.databases.listDocuments(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS_ID,
        queries: [Query.equal('title', title), Query.equal('user_id', userId)],
      );
      if (response.documents.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking title existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
        actions: [
          IconButton(
            onPressed: () async {
              final AuthAPI appwrite = context.read<AuthAPI>();
              final String userId = appwrite.currentUser.$id;
              bool exists = await checkIfTitleExists(widget.title);
              if (exists) {
                try {
                  final bookmark = bookmarks!.firstWhere(
                    (bookmark) =>
                        bookmark.data['title'] == widget.title &&
                        bookmark.data['user_id'] == userId,
                  );
                  deleteBookmark(bookmark.$id);
                } catch (e) {
                  showAlert(
                    title: 'Error',
                    text: 'No matching bookmark found to delete.',
                  );
                }
              } else {
                addBookmark();
              }
            },
            icon: articleSaved ? Icon(savedIcon) : Icon(notSavedIcon),
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.data,
        javascriptMode: JavascriptMode.disabled,
        onWebViewCreated: (WebViewController webViewController) {
          this.webViewController = webViewController;
        },
      ),
    );
  }
}
