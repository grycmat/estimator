import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class NewTaskSheet extends StatefulWidget {
  const NewTaskSheet({Key? key}) : super(key: key);

  @override
  State<NewTaskSheet> createState() => _NewTaskSheetState();
}

class _NewTaskSheetState extends State<NewTaskSheet> {
  final _name = TextEditingController();
  final _estimation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300 + MediaQuery.of(context).viewInsets.bottom,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                  labelText: 'Task',
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              style: const TextStyle(fontSize: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _estimation,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Estimation'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SaveButton(
                      onPressed: () {
                        try {
                          var userId =
                              Provider.of<User>(context, listen: false).id;
                          var project = Provider.of<ProjectEstimate>(context,
                              listen: false);
                          var task = Task(name: _name.text);
                          var estimation = Estimate(
                            userId: userId,
                            value: int.parse(_estimation.text),
                          );
                          task.addEstimation(estimation);
                          project.addTask(task);
                        } catch (error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Something went wrong'),
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
