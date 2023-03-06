import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Models/user.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!;
  Future<void> refreshData() async {
    User user = await FireStoreMethods().getDataProvider();
    _user = user;
    notifyListeners();
  }
}
