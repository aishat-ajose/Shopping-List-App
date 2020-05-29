import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/models/userList.dart';

class User extends ChangeNotifier{
  List<UserList> _userList = [];

  UnmodifiableListView<UserList> get userList => UnmodifiableListView(_userList);

  int get totalItems => _userList.length;

  void add(UserList item) {
    _userList.add(item);
    notifyListeners();
  }

  void removeAll() {
    _userList.clear();
    notifyListeners();
  }
}