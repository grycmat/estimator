import 'package:estimator/models/task.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstimationPage extends StatelessWidget {
  EstimationPage({Key? key}) : super(key: key);
  final _name = TextEditingController();
  final _estimation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectEstimate>(
      builder: (_, project, __) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const Text('Estimating wild'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openNewTaskSheet(context, project);
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: 60,
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: project.getItemCount(),
            itemBuilder: (ctx, index) => Container(
              child: ListTile(
                title: Text(project.getItem(index).name),
                subtitle: Text(
                  project.getItem(index).estimations[0].value.toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openNewTaskSheet(BuildContext context, ProjectEstimate project) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 500,
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
                  style: const TextStyle(fontSize: 70),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            var task = Task(name: _name.text);
                            var estimation = Estimate(
                              userId: '1',
                              value: int.parse(_estimation.text),
                            );
                            task.addEstimation(estimation);
                            project.addTask(task);
                            Navigator.of(context).pop();
                          },
                          child: const Text('GO GO GO'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
