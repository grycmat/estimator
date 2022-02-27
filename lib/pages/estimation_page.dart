import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/widgets/new_task_sheet.dart';
import 'package:estimator/widgets/task_item.dart';
import 'package:estimator/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstimationPage extends StatelessWidget {
  EstimationPage({Key? key}) : super(key: key);

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
            _openNewTaskSheet(context);
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
        body: const TasksList(),
      ),
    );
  }

  void _openNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => NewTaskSheet());
  }
}
