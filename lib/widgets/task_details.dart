import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({Key? key, required this.task}) : super(key: key);
  final Task task;
  final _estimation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: task.id,
          child: Material(
            color: Colors.transparent,
            child: Text(
              task.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _estimation,
                decoration: InputDecoration(labelText: 'Estimation'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  var project =
                      Provider.of<ProjectEstimate>(context, listen: false);
                  var estimation =
                      Estimate(userId: '1', value: int.parse(_estimation.text));
                  task.addEstimation(estimation);
                  project.updateEstimations(task);
                  Navigator.of(context).pop();
                },
                child: Text('update'))
          ],
        ),
      ),
    );
  }
}
