import 'package:estimator/pages/estimation_page.dart';
import 'package:estimator/providers/project_estimate.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _timer;
  final _name = TextEditingController();
  final db = FirebaseFirestore.instance.collection('project_estimation');
  String _code = '';

  Future<bool> _createNewProjectEstimate() async {
    try {
      var newProject = await db.add({});
      var projectRef = db.doc(newProject.id);
      var newUser =
          await projectRef.collection('users').add({'name': _name.text});
      await projectRef.set({'owner': newUser.id});
      return true;
    } catch (error) {
      return false;
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
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Your fabulous name!',
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
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Divider(),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: const Text(
                        'or you can just',
                        style: TextStyle(
                            backgroundColor: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var response = await _createNewProjectEstimate();
                    if (response) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => EstimationPage(),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Start new estimation!',
                      style: TextStyle(fontSize: 30),
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
