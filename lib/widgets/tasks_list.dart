import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/widgets/task_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    var _stream = Provider.of<ProjectEstimate>(context).tasksStream;
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error while loading data'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Loading...'),
              ),
            );
          });
        }

        if (snapshot.data == null) {
          return Container();
        }

        print(snapshot.data);

        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: snapshot.data!.docs.map((element) {
                      var task = Task.fromMap(element);

                      return Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskView(task: task),
                      ));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
