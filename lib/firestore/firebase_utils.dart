import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getFirebaseTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.FromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFirebase(Task task) {
    CollectionReference<Task> tasksCollection =
        FirebaseUtils.getFirebaseTasksCollection();
    DocumentReference<Task> docRef = tasksCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> getTasks() {
    CollectionReference<Task> tasksCollection =
        FirebaseUtils.getFirebaseTasksCollection();
    return tasksCollection.get().then((QuerySnapshot<Task> snapshot) {
      snapshot.docs.forEach((doc) {
        var task = doc.data();
        print(
            '${doc.id} => ${task.id} , ${task.title} , ${task.desc} , ${task.dateTime}');
      });
    }).catchError((error) => print("Failed to fetch users: $error"));
  }
}
