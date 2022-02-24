import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Timer? _timer;
  final _name = TextEditingController();
  final db = FirebaseFirestore.instance.collection('project_estimation');

  _createNewProjectEstimate() async {
    try {
      var newProject = await db.add({});
      var projectRef = db.doc(newProject.id);
      var newUser =
          await projectRef.collection('users').add({'name': _name.text});
      await projectRef.set({'owner': newUser.id});
    } catch (error) {
      print(error);
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
                    border: const OutlineInputBorder(),
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
                    _timer = Timer(const Duration(seconds: 1), () {
                      print(string);
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Provide us your estimation code',
                    border: const OutlineInputBorder(),
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
                    _createNewProjectEstimate();
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
