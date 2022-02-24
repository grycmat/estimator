import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class ProjectEstimate extends ChangeNotifier {
  ProjectEstimate() : super();
  List<Task> tasks = [];
  String owner = '';

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
}
