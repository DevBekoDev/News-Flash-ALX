import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/appwrite/database_api.dart';
import 'package:news_flash/screens/news_details.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final _database = DatabaseAPI();

  List<Document>? bookmarks = [];
  AuthStatus authStatus = AuthStatus.uninitialized;

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    authStatus = appwrite.status;
    final String userId = appwrite.currentUser.$id;
    loadBookmarks();
    _database.getBookmarks(userId: userId);
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

  // Delete the article data from the bookmarks collection
  Future<void> deleteBookmark(String id) async {
    try {
      await _database.deleteBookmark(id: id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bookmarks')),
        backgroundColor: const Color.fromARGB(255, 199, 193, 174),
      ),
      body: bookmarks == null || bookmarks!.isEmpty
          ? const Center(
              child: Text("No Bookmarked Articles Found!"),
            )
          : ListView.builder(
              itemCount: bookmarks!.length,
              itemBuilder: (context, index) {
                // Extract the title from each bookmark
                final title = bookmarks![index].data['title'];
                final url = bookmarks![index].data['url'];

                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return NewsDetails(data: url, title: title);
                            }));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 199, 193, 174)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
