import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:provider/provider.dart';

String NEWS_LANGUAGE = 'en'; // Default language

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  // List of languages and their codes
  final Map<String, String> languages = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Chinese': 'zh',
    'Arabic': 'ar',
  };

  // Variable to hold the selected language code
  String selectedLanguage = NEWS_LANGUAGE;

  @override
  void initState() {
    super.initState();
    _loadUserPreference();
  }

  // Load user preferences from Appwrite
  void _loadUserPreference() async {
    final AuthAPI authAPI = context.read<AuthAPI>();

    // Fetch user preferences
    final preferences = await authAPI.getUserPreferences();

    if (preferences.data.containsKey('lang')) {
      setState(() {
        selectedLanguage = preferences.data['lang'];
        NEWS_LANGUAGE = selectedLanguage;
      });
    } else {
      setState(() {
        selectedLanguage = 'en';
        NEWS_LANGUAGE = selectedLanguage;
      });
    }
  }

  // Save user preferences to Appwrite
  void _saveUserPreference(String language) async {
    final AuthAPI authAPI = context.read<AuthAPI>();

    // Update the user's language preference
    await authAPI.updatePreferences(lang: language);
    const snackbar = SnackBar(content: Text('Language preference updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change News Language'),
        backgroundColor: const Color.fromARGB(255, 199, 193, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header
            const Text(
              'Select News Language:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: languages.keys.map((language) {
                  return _buildLanguageOption(language);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = languages[language]!;
          NEWS_LANGUAGE = selectedLanguage;
          _saveUserPreference(selectedLanguage);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedLanguage == languages[language]
              ? Colors.blueAccent.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          border: Border.all(
            color: selectedLanguage == languages[language]
                ? Colors.blueAccent
                : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: languages[language]!,
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value!;
                    NEWS_LANGUAGE = selectedLanguage;
                    _saveUserPreference(selectedLanguage);
                  });
                },
              ),
              Text(
                language,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
