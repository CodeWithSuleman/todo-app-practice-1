import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_practice/models/todo.dart';

final firebaseFireStore = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> collection =
    firebaseFireStore.collection('user');

class FirebaseCRUD {
  Future<void> createUser(User user) async {
    await collection.doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    await collection.doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await collection.doc(id).delete();
  }

  Future<List<User>> getUsers() async {
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) {
      return User.fromJson(doc.data());
    }).toList();
  }
}
