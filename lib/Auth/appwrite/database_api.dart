import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:news_flash/Auth/appwrite/auth_api.dart';
import 'package:news_flash/constants/constants.dart';

class DatabaseAPI {
  Client client = Client();
  late final Account account;
  late final Databases databases;
  final AuthAPI auth = AuthAPI();

  DatabaseAPI() {
    init();
  }

  init() {
    client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();
    account = Account(client);
    databases = Databases(client);
  }

  Future<DocumentList> getMessages() {
    return databases.listDocuments(
      databaseId: APPWRITE_DATABASE_ID,
      collectionId: COLLECTION_BOOKMARKS,
    );
  }

  Future<Document> addMessage({required String message}) {
    return databases.createDocument(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS,
        documentId: ID.unique(),
        data: {
          'text': message,
          'date': DateTime.now().toString(),
          'user_id': auth.userid
        });
  }

  Future<dynamic> deleteMessage({required String id}) {
    return databases.deleteDocument(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS,
        documentId: id);
  }
}
