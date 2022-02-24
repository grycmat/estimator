import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  User() : super();
  String id = '';
  String name = '';
  bool isOwner = true;
}
