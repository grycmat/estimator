import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/new_task_sheet.dart';
import 'package:estimator/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';

class EstimationPage extends StatelessWidget {
  const EstimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);
    return Consumer<ProjectEstimate>(
      builder: (_, project, __) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  print(project.projectId);
                  Share.share(project.projectId!);
                },
                icon: const Icon(UniconsLine.share_alt),
              ),
            ),
          ],
          centerTitle: true,
          title: Text(_user.name),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openNewTaskSheet(context);
          },
          child: const Icon(Icons.add),
        ),
        body: const SingleChildScrollView(child: TasksList()),
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
