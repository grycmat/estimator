import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TaskDetailsDialog extends StatelessWidget {
  TaskDetailsDialog({Key? key, required this.task}) : super(key: key);
  final Task task;
  final _myEstimation = TextEditingController();
  final _approvedEstimation = TextEditingController();
  final _user = GetIt.I<User>();
  final _project = GetIt.I<ProjectEstimate>();

  void _presetApprovedValue(double value) {
    _approvedEstimation.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    EstimateData _estimationData = task.calculateEstimations();
    _approvedEstimation.text = _estimationData.average.toString();

    return Container(
      height: 265,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Hero(
              tag: task.id,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  task.name,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _myEstimation,
                      decoration: const InputDecoration(
                        labelText: 'My estimation',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SaveButton(onPressed: () {
                  task.updateEstimation(
                    userId: _user.id,
                    value: int.parse(_myEstimation.text),
                  );
                  _project.update(task);

                  Navigator.of(context).pop();
                })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _presetApprovedValue(_estimationData.min);
                  },
                  child: Text(
                    _estimationData.min.toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _approvedEstimation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _presetApprovedValue(_estimationData.max);
                  },
                  child: Text(
                    _estimationData.max.toString(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      task.approvedEstimation = _approvedEstimation.text;

                      _project.update(task);
                      print(task.approvedEstimation);

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Approve',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
