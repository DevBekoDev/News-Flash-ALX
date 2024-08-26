import 'package:flutter/material.dart';

class NewsLanguageProvider extends ChangeNotifier {
  String _newsLanguage = 'en'; // Default language

  String get newsLanguage => _newsLanguage;

  void setNewsLanguage(String newLanguage) {
    if (_newsLanguage != newLanguage) {
      _newsLanguage = newLanguage;
      notifyListeners();
    }
  }
}
