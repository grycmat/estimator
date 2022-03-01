import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({Key? key, required this.task}) : super(key: key);
  final Task task;
  final _estimation = TextEditingController();

  void _addEstimation(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    var project = Provider.of<ProjectEstimate>(context, listen: false);
    var estimation =
        Estimate(userId: user.id, value: int.parse(_estimation.text));
    task.addEstimation(estimation);
    project.update(task);
  }

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context, listen: false);
    var _project = Provider.of<ProjectEstimate>(context, listen: false);
    _estimation.text = task.getUserEstimation(_user.id).value.toString();

    return Container(
      height: 100,
      child: Column(
        children: [
          Hero(
            tag: task.id,
            child: Material(
              color: Colors.transparent,
              child: Text(
                task.name,
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _estimation,
                    decoration: const InputDecoration(
                      labelText: 'Estimation',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SaveButton(onPressed: () {
                  task.updateEstimation(
                    userId: _user.id,
                    value: int.parse(_estimation.text),
                  );
                  _project.update(task);

                  Navigator.of(context).pop();
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
