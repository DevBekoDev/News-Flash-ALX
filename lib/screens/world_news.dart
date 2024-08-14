import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_flash/models/news_model.dart';

class WorldNews extends StatefulWidget {
  const WorldNews({super.key});

  @override
  State<WorldNews> createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
  NewsViewModel newsViewModel = NewsViewModel();
  Future<NewsModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c5137648dab347eab35d145ebc88e8ad';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsModel.fromJson(body);
    }
    throw Exception('Error');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    final format = DateFormat('MMMM dd, yyyy');
    return FutureBuilder<NewsModel>(
      future: fetchNewsHeadlines(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: snapshot.data?.articles?.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DateTime dateTime = DateTime.parse(
                    snapshot.data!.articles![index].publishedAt.toString());
                return SizedBox(
                    child: Container(
                  height: 370,
                  width: width * .9,
                  padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl:
                          snapshot.data!.articles![index].urlToImage.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        child: const SpinKitCircle(
                          color: Colors.amber,
                          size: 50,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.articles![index].title.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      format.format(dateTime),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ]),
                ));
              });
        } else {
          return const Center(
            child: Text("Error loading news"),
          );
        }
      },
    );
  }
}
