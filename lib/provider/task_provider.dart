import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/model/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  Future<void> getAllTasks() async {
    var tasksCollection = FirebaseUtils.getFirebaseTasksCollection();
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
      return task2.dateTime.compareTo(task1.dateTime);
    });

    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    getAllTasks();
  }

  void deleteTaskFromFirebase(Task task) {
    var tasksCollection = FirebaseUtils.getFirebaseTasksCollection();
    tasksCollection.doc(task.id).delete().timeout(Duration(seconds: 1),
        onTimeout: () {
      print('Task Deleted Successfully');
      getAllTasks();
    });
  }
}
