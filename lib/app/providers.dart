import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/models/list.dart';
import 'package:flutter_todo_app/services/firestore_service.dart';

// This is used to perform Authetication process
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

//  This will provide us with authetication changes that happen through app
final authStateChangesProvider = StreamProvider<User?>(
  (ref) {
    return ref
        .watch(firebaseAuthProvider)
        .authStateChanges(); // we use ref.watch because we want to watch for changes.
  },
);

final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});


