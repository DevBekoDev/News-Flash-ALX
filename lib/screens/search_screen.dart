import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_flash/constants/constants.dart';
import 'dart:convert';

import 'package:news_flash/screens/news_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];
  Set<String> _bookmarkedTitles = {}; // To track bookmarked articles by title

  void _fetchData(String query) async {
    final url =
        'https://newsapi.org/v2/everything?q=$query&apikey=$NEWS_API_KEY';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _searchResults = data['articles'];
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _onBookmarkChanged(String title) {
    setState(() {
      if (_bookmarkedTitles.contains(title)) {
        _bookmarkedTitles.remove(title);
        // Call a function to remove the bookmark from the database
        _removeBookmark(title);
      } else {
        _bookmarkedTitles.add(title);
        // Call a function to add the bookmark to the database
        _addBookmark(title);
      }
    });
  }

  void _addBookmark(String title) {
    // Logic to add the bookmark to the database
    // For example, call a service that interacts with the database API
    print('Bookmark added: $title');
  }

  void _removeBookmark(String title) {
    // Logic to remove the bookmark from the database
    // For example, call a service that interacts with the database API
    print('Bookmark removed: $title');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 234, 223),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 199, 193, 174),
        title: const Text('Search Articles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.purple)),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _fetchData(value); // Fetch new data as the user types
                } else {
                  setState(() {
                    _searchResults =
                        []; // Clear the results if the query is empty
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final title = _searchResults[index]['title'].toString();
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                title,
                                style: const TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return NewsDetails(
                                    data: _searchResults[index]['url'],
                                    title: title,
                                    onBookmarkChanged: () =>
                                        _onBookmarkChanged(title),
                                  );
                                }));
                              },
                            ),
                            const SizedBox(
                              width: 430,
                              child: Divider(
                                height: 0,
                                thickness: 1,
                                color: Colors.black,
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : const SizedBox(
                      child: Center(
                        child: Text(
                          'Try Something New 😁',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
