import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    var data = task.calculateEstimations();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(8.0),
      elevation: 4,
      child: ListTile(
        trailing: Container(width: 20, height: 20, color: Colors.red),
        contentPadding: EdgeInsets.all(20),
        title: Text(task.name),
        subtitle: Container(
          child: Column(
            children: [
              Text(
                task.estimations[0].value.toString(),
              ),
              SliderTheme(
                data: SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  min: data.min,
                  max: data.max,
                  value: data.average,
                  onChanged: (val) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
