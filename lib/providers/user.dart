import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  User() : super();
  String _id = '';
  String _name = '';
  bool _isOwner = false;

  get id => _id;
  get name => _name;
  get isOwner => _isOwner;

  create({required String id, required String name, bool isOwner = false}) {
    _id = id;
    _name = name;
    _isOwner = isOwner;
    notifyListeners();
  }
}
