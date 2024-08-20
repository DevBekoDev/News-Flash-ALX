import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  void _fetchData(String query) async {
    final url =
        'https://newsapi.org/v2/everything?q=$query&apikey=647882b0a2314fed9069799f69a42a3a';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
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
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  if (_searchResults.isNotEmpty) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            _searchResults[index]['title'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return NewsDetails(
                                  data: _searchResults[index]['url'],
                                  title: _searchResults[index]['title']);
                            }));
                          },
                        ),
                        const Divider(
                          height: 0,
                          thickness: 1,
                          color: Colors.black,
                        )
                      ],
                    );
                  } else if (_searchResults.isEmpty) {
                    return const SizedBox(
                      child: Center(
                        child: Text('Try Something news 😁'),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Center(
                        child: Text('Something went wrong!!'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
