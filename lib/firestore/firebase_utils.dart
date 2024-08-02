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
}
