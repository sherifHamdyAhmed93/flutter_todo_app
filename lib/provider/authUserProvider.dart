import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/user.dart';

class AuthUserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser user) {
    currentUser = user;
    notifyListeners();
  }
}
