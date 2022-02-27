import 'package:estimator/pages/estimation_page.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/with_wallpaper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _timer;
  final _name = TextEditingController();
  String _code = '';

  Future<String?> _createNewProjectEstimate(ProjectEstimate project) async {
    try {
      var newProject = await project.db.add({});
      project.projectId = newProject.id;
      var projectRef = project.projectRef;
      var newUser =
          await projectRef!.collection('users').add({'name': _name.text});
      await project.projectRef!.set({'owner': newUser.id});
      return newUser.id;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Your fabulous name <3',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (string) {
                    if (_timer != null && _timer!.isActive) {
                      _timer!.cancel();
                    }
                    _timer = Timer(const Duration(milliseconds: 400), () {
                      setState(() {
                        _code = string;
                      });
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Provide us your estimation code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'And join estimation',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Text(
                        'or you can just',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var project =
                        Provider.of<ProjectEstimate>(context, listen: false);
                    var userId = await _createNewProjectEstimate(project);
                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                      return;
                    }
                    var userProvider =
                        Provider.of<User>(context, listen: false);
                    userProvider.create(
                        id: userId, name: _name.text, isOwner: true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => WithWallpaper(
                          child: EstimationPage(),
                        ),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Start new estimation!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
