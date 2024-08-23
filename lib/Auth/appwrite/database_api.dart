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

  Future<DocumentList> getBookmarks() {
    return databases.listDocuments(
      databaseId: APPWRITE_DATABASE_ID,
      collectionId: COLLECTION_BOOKMARKS_ID,
    );
  }

  Future<Document> addBookmark({required String title, required String url}) {
    return databases.createDocument(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS_ID,
        documentId: ID.unique(),
        data: {
          'title': title,
          'date': DateTime.now().toString(),
          'url': url,
          'user_id': auth.userid
        });
  }

  Future<dynamic> deleteBookmark({required String id}) {
    return databases.deleteDocument(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS_ID,
        documentId: id);
  }
}
