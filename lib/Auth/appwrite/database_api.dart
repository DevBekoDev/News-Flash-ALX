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

  Future<DocumentList> getBookmarks({required String userId}) async {
    try {
      final response = await databases.listDocuments(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: COLLECTION_BOOKMARKS_ID,
        queries: [Query.equal('user_id', userId)], // Filter by userId
      );
      return response;
    } catch (e) {
      print('Error fetching bookmarks: $e');
      throw e;
    }
  }

  Future<Document> addBookmark(
      // ignore: non_constant_identifier_names
      {required String title,
      required String url,
      // ignore: non_constant_identifier_names
      required String user_id}) {
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
