import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';
import 'package:news_flash/constants/constants.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthAPI extends ChangeNotifier {
  Client client = Client();
  late final Account account;

  late User _currentUser;

  AuthStatus _status = AuthStatus.uninitialized;

  // Getter methods
  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get username => _currentUser.name;
  String? get email => _currentUser.email;
  String? get userid => _currentUser.$id;

  // Constructor
  AuthAPI() {
    init();
    loadUser();
    _checkAuthState();
  }

  // Initialize the Appwrite client
  init() {
    client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();
    account = Account(client);
  }

  loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  void _checkAuthState() async {
    try {
      // Check if user is authenticated from Appwrite
      final user = await account.get();
      if (user != null) {
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners(); // Notify listeners of status change
  }

  Future<User> createUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final user = await account.create(
          userId: ID.unique(), email: email, password: password, name: name);
      return user;
    } finally {
      notifyListeners();
    }
  }

  Future<Session> createEmailSession(
      {required String email, required String password}) async {
    try {
      final session = await account.createEmailPasswordSession(
          email: email, password: password);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  signOut() async {
    try {
      //await account.deleteSession(sessionId: 'current');
      await account.deleteSessions();
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  // Fetch user preferences
  Future<Preferences> getUserPreferences() async {
    try {
      return await account.getPrefs();
    } on AppwriteException catch (e) {
      print('Error fetching user preferences: ${e.message}');
      return Preferences(
          data: {}); // Return empty preferences if there's an error
    }
  }

  // Update user preferences
  Future<void> updatePreferences({required String lang}) async {
    try {
      await account.updatePrefs(prefs: {'lang': lang});
    } on AppwriteException catch (e) {
      print('Error updating user preferences: ${e.message}');
    }
  }
}
