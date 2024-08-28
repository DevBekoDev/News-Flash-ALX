import 'package:flutter/material.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/Auth/appwrite/change_language_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserPreference();
  }

  // Load user preferences from Appwrite
  void _loadUserPreference() async {
    final AuthAPI authAPI = context.read<AuthAPI>();
    final newsLanguageProvider = context.read<NewsLanguageProvider>();

    // Fetch user preferences
    final preferences = await authAPI.getUserPreferences();

    if (preferences.data.containsKey('lang')) {
      newsLanguageProvider.setNewsLanguage(preferences.data['lang']);
    } else {
      newsLanguageProvider
          .setNewsLanguage('en'); // Default to 'en' if no preference is set
    }
  }

  // Save user preferences to Appwrite
  void _saveUserPreference(String language) async {
    final AuthAPI authAPI = context.read<AuthAPI>();
    final newsLanguageProvider = context.read<NewsLanguageProvider>();

    // Update the user's language preference
    await authAPI.updatePreferences(lang: language);

    // Update the provider
    newsLanguageProvider.setNewsLanguage(language);

    // Show a snackbar to indicate that the preferences have been updated
    const snackbar = SnackBar(content: Text('Language preference updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final newsLanguageProvider = context.watch<NewsLanguageProvider>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 234, 223),
      appBar: AppBar(
        title: const Text('Change News Language'),
        backgroundColor: const Color.fromARGB(255, 199, 193, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
                  return _buildLanguageOption(
                      language, newsLanguageProvider.newsLanguage);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, String currentLanguage) {
    return GestureDetector(
      onTap: () {
        _saveUserPreference(languages[language]!);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentLanguage == languages[language]
              ? Colors.blueAccent.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          border: Border.all(
            color: currentLanguage == languages[language]
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
                groupValue: currentLanguage,
                onChanged: (String? value) {
                  if (value != null) {
                    _saveUserPreference(value);
                  }
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
