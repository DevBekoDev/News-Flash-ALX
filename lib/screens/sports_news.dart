import 'package:flutter/material.dart';

class SportsNews extends StatefulWidget {
  const SportsNews({super.key});

  @override
  State<SportsNews> createState() => _SportsNewsState();
}

class _SportsNewsState extends State<SportsNews> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        child: Text("Sports",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 45, color: Colors.amber)),
      ),
    );
  }
}
