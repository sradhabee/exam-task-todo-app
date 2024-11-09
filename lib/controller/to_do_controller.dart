import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToDoController with ChangeNotifier {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Stream<QuerySnapshot> get tasksStream => _tasksCollection.snapshots();

  Future<void> addTask(String title) async {
    await _tasksCollection.add({
      'title': title,
      'completed': false,
    });
  }

  Future<void> toggleAction(String taskId, bool isCompleted) async {
    await _tasksCollection.doc(taskId).update({'completed': !isCompleted});
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }
}

