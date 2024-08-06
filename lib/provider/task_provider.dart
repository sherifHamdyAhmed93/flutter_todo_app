import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/model/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  Future<void> getAllTasks(String userID) async {
    var tasksCollection = FirebaseUtils.getFirebaseTasksCollection(userID);
    QuerySnapshot<Task> querySnapshot = await tasksCollection.get();
    List<QueryDocumentSnapshot<Task>> queryDocumentSnapshot =
        querySnapshot.docs;
    taskList = queryDocumentSnapshot.map((e) => e.data()).toList();

    taskList = taskList.where((task) {
      if (task.dateTime.day == selectedDate.day &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void setSelectedDate(DateTime date, String userID) {
    selectedDate = date;
    getAllTasks(userID);
  }

  Future<void> deleteTaskFromFirebase(Task task, String userID) {
    var tasksCollection = FirebaseUtils.getFirebaseTasksCollection(userID);
    return tasksCollection.doc(task.id).delete().then((value) {
      print('Task Deleted Successfully');
      getAllTasks(userID);
    });
  }

  Future<void> updateTaskFromFirebase(Task task, String userID) {
    var tasksCollection = FirebaseUtils.getFirebaseTasksCollection(userID);
    return tasksCollection.doc(task.id).update(task.toFireStore());
  }
}
