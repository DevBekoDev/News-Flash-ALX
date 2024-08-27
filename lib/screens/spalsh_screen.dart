import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/screens/home_screen.dart';
import 'package:news_flash/Auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    // Simulating a delay for the splash screen (3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    final authAPI = context.read<AuthAPI>();

    // Check if the user is authenticated
    if (authAPI.status == AuthStatus.authenticated) {
      // Navigate to HomeScreen if authenticated
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Navigate to LoginScreen if not authenticated
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 234, 216),
      body: Center(
        child: Image.asset('lib/images/logo_final.png',
            width: 350, height: 350), // Adjust the width and height as needed
      ),
    );
  }
}
