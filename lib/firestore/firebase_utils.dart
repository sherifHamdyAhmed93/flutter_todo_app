import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/model/user.dart';

import '../model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getFirebaseTasksCollection(String userID) {
    return FirebaseUtils.getUsersCollection()
        .doc(userID)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.FromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFirebase(Task task, String userID) {
    CollectionReference<Task> tasksCollection =
        FirebaseUtils.getFirebaseTasksCollection(userID);
    DocumentReference<Task> docRef = tasksCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFirestore(MyUser user) {
    print(user.id);
    return FirebaseUtils.getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String userID) async {
    DocumentSnapshot<MyUser> querySnapshot =
        await FirebaseUtils.getUsersCollection().doc(userID).get();
    return querySnapshot.data();
  }
}
