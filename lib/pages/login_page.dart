import 'package:estimator/pages/estimation_page.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:estimator/providers/user.dart';
import 'package:estimator/widgets/with_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _name = TextEditingController();
  final _code = TextEditingController();
  final _project = GetIt.I<ProjectEstimate>();
  final _user = GetIt.I<User>();
  String? _nameError;
  String? _codeError;

  Future<String?> _createNewProjectEstimate(ProjectEstimate project) async {
    try {
      var newProject = await project.createNewProject();
      project.projectId = newProject.id;
      var usersRef = project.usersRef;
      var newUser = await usersRef!.add({'name': _name.text});
      await project.projectRef!.set({'owner': newUser.id});
      return newUser.id;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<String?>? _joinEstimation(ProjectEstimate project) async {
    try {
      project.projectId = _code.text;
      var usersRef = project.usersRef;
      var newUser = await usersRef!.add({'name': _name.text});
      return newUser.id;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _code.dispose();
    super.dispose();
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
                  decoration: InputDecoration(
                    labelText: 'Your fabulous name <3',
                    border: const OutlineInputBorder(),
                    errorText: _nameError,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _code,
                  decoration: InputDecoration(
                    labelText: 'Provide us your estimation code',
                    border: const OutlineInputBorder(),
                    errorText: _codeError,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_name.text == '' || _code.text == '') {
                      setState(() {
                        _nameError =
                            _name.text == '' ? 'Name cannot be empty' : '';
                        _codeError = _code.text == ''
                            ? 'You need to use code to join'
                            : '';
                      });
                      return;
                    }
                    var userId = await _joinEstimation(_project);
                    _user.create(id: userId!, name: _name.text);

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
                    if (_name.text == '') {
                      setState(() {
                        _nameError = 'Name cannot be empty';
                      });

                      return;
                    }
                    var userId = await _createNewProjectEstimate(_project);
                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                      return;
                    }
                    _user.create(id: userId, name: _name.text, isOwner: true);
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
