import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          task.name,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(child: Text(task.name)),
    );
  }
}
