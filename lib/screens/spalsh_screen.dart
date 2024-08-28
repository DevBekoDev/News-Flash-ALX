import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 234, 216),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 234, 216),
      body: Center(
        child:
            Image.asset('lib/images/logo_final.png', width: 350, height: 350),
      ),
    );
  }
}
