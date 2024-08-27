import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/appwrite/change_language_provider.dart';
import 'package:news_flash/Auth/screens/login_screen.dart';
import 'package:news_flash/Auth/screens/signup_screen.dart';
import 'package:news_flash/models/news_model.dart';
import 'package:news_flash/screens/home_screen.dart';
import 'package:appwrite/appwrite.dart';
import 'package:news_flash/screens/spalsh_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewsLanguageProvider()),
      ChangeNotifierProvider(create: ((context) => AuthAPI())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Client client = Client();

  NewsViewModel newsViewModel = NewsViewModel();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus(); // Call the function to check authentication status with a delay
  }

  void _checkAuthenticationStatus() async {
    // Delay for 3 seconds to show the splash screen
    await Future.delayed(const Duration(seconds: 3));

    final AuthAPI authAPI = context.read<AuthAPI>();
    if (authAPI.status == AuthStatus.authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
