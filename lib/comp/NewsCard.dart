import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_flash/screens/news_details.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String url;
  final DateTime publishedAt;

  const NewsCard({
    super.key,
    required this.title,
    required this.url,
    required this.publishedAt,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    final format = DateFormat('MMMM dd, yyyy');

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return NewsDetails(data: url, title: title);
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: EdgeInsets.symmetric(horizontal: height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            if (imageUrl != null) ...[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  height: 250,
                  width: width * .9,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SpinKitCircle(
                    color: Colors.amber,
                    size: 50,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ] else ...[
              const SizedBox(height: 15),
            ],
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              format.format(publishedAt),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
