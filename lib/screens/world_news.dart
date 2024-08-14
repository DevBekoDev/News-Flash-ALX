import 'package:flutter/material.dart';

class WorldNews extends StatefulWidget {
  const WorldNews({super.key});

  @override
  State<WorldNews> createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        child: Text("World",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 45, color: Colors.amber)),
      ),
    );
  }
}
