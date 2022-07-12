import 'package:flutter_todo_app/models/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/models/user_data.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addList(
    Todo list,
  ) async {
    final docId =
        firestore.collection("users").doc(uid).collection("todo").doc().id;
    await firestore
        .collection("users")
        .doc(uid)
        .collection("todo")
        .doc(docId)
        .set(list.toJson(docId));
    // .then((value) => print(value))
    // .catchError((onError) => print("Error"));
  }

  Stream<List<Todo>> getList() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("todo")
        .orderBy("formatedDate", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Todo.fromJson(d);
            }).toList());
  }

  Future<void> deleteList(String id) async {
    return await firestore.collection("todo").doc(id).delete();
  }

  Future<void> addUser(
    UserData user,
  ) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

 Future<void> toogleTodoStatus(String id) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("todo")
        .doc(id)
        .update({"isDone": true});
  }


Future<void> UpdateTodoList(
    Todo list,
  ) async {
    final docId =
        firestore.collection("users").doc(uid).collection("todo").doc().id;
    await firestore
        .collection("users")
        .doc(uid)
        .collection("todo")
        .doc(docId)
        .set(list.toJson(docId));
    // .then((value) => print(value))
    // .catchError((onError) => print("Error"));
  }
  // static Future<void> updateTodo(Todo todo) async {
  //   // Future<void> updateTodo(Todo todo, String id) async {
  //   final docTodo = FirebaseFirestore.instance
  //       // .collection("users")
  //       // .doc(uid)
  //       .collection("todo")
  //       .doc(todo.id).update(todo.toJso());

  //   // await docTodo.update(todo.toJso());
  //   //   return firestore
  //   //       .collection("users")
  //   //       .doc(uid)
  //   //       .collection("todo")
  //   //       .doc(id)
  //   //       .update(todo.toJso());
  //   }
}
