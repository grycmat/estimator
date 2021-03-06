import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class ProjectEstimate extends ChangeNotifier {
  ProjectEstimate() : super();
  String? _projectId;
  List<Task> tasks = [];
  String owner = '';

  set projectId(String? id) => _projectId = id;
  String? get projectId => _projectId;

  addTask(Task task) {
    tasks.add(task);

    tasksRef?.add(task.toMap());
  }

  int getItemCount() {
    return tasks.length;
  }

  getItem(int index) {
    return tasks[index];
  }

  Future<DocumentReference<Map<String, dynamic>>> createNewProject() async {
    return await db.add({});
  }

  CollectionReference<Map<String, dynamic>> get db =>
      FirebaseFirestore.instance.collection('project_estimation');

  DocumentReference<Map<String, dynamic>>? get projectRef =>
      _projectId != null ? db.doc(_projectId) : null;

  CollectionReference<Map<String, dynamic>>? get usersRef =>
      projectRef?.collection('users');

  CollectionReference<Map<String, dynamic>>? get tasksRef =>
      projectRef?.collection('tasks');

  Stream<QuerySnapshot<Map<String, dynamic>>>? get tasksStream =>
      tasksRef?.snapshots();

  DocumentReference<Map<String, dynamic>>? getTaskRef(String id) =>
      tasksRef?.doc(id);
  DocumentReference<Map<String, dynamic>>? getTaskEstimationsRef(String id) =>
      tasksRef?.doc('$id.estimations');

  void update(Task task) {
    print(task.toMap());
    tasksRef?.doc(task.id).update(task.toMap());
  }
}
