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

  void initState() {
    super.initState();

    // Start a timer to delay the navigation by 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _checkAuthenticationStatus();
    });
  }

  bool _checkAuthenticationStatus() {
    final AuthAPI authAPI = context.read<AuthAPI>();
    if (authAPI.status == AuthStatus.authenticated) {
      return true;
    } else {
      return false;
    }
  }
  // This widget is the root of your application.

  NewsViewModel newsViewModel = NewsViewModel();
  int currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    final value_1 = _checkAuthenticationStatus();
    return MaterialApp(
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: value == AuthStatus.uninitialized
            ? const Scaffold(
                body: SplashScreen(),
              )
            : value_1 == true
                ? const HomeScreen()
                : const LoginScreen());
  }
}
