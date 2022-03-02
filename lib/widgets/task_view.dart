import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/widgets/estimations_slider.dart';
import 'package:estimator/widgets/save_button.dart';
import 'package:estimator/widgets/task_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    EstimateData data = task.calculateEstimations();
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            content: TaskDetailsDialog(task: task),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              EstimationsSlider(
                data: data,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      data.min.toString(),
                    ),
                    Text(
                      data.average.toString(),
                    ),
                    Text(
                      data.max.toString(),
                    ),
                  ],
                ),
              ),
              Container(
                  child: task.approvedEstimation != ''
                      ? Icon(UniconsSolid.check)
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
