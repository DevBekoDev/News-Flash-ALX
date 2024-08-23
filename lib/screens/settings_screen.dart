import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //sign out method
  signOut() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsetsDirectional.only(start: 70),
                child: Row(
                  children: [
                    Text(
                      '🔖',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Bookmarks",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsetsDirectional.only(start: 70),
                child: Row(
                  children: [
                    Text(
                      '🌍',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Search Language",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.red)),
                onPressed: () {
                  signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
