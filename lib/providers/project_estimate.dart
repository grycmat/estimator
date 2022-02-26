import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class ProjectEstimate extends ChangeNotifier {
  ProjectEstimate() : super();
  String? _projectId;
  List<Task> tasks = [];
  String owner = '';

  set projectId(String id) => _projectId = id;

  addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  int getItemCount() {
    return tasks.length;
  }

  getItem(int index) {
    return tasks[index];
  }

  CollectionReference<Map<String, dynamic>> get db =>
      FirebaseFirestore.instance.collection('project_estimation');

  DocumentReference<Map<String, dynamic>>? get projectRef =>
      _projectId != null ? db.doc(_projectId) : null;

  CollectionReference<Map<String, dynamic>>? get tasksRef =>
      projectRef?.collection('tasks');
}
