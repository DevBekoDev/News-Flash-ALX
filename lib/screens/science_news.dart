import 'package:flutter/material.dart';

class ScienceNews extends StatefulWidget {
  const ScienceNews({super.key});

  @override
  State<ScienceNews> createState() => _ScienceNewsState();
}

class _ScienceNewsState extends State<ScienceNews> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        child: Text("science",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 45, color: Colors.amber)),
      ),
    );
  }
}
