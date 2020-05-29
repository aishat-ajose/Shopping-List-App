import 'dart:collection';
import 'package:shoppinglist/models/foodItems.dart';

class UserList{
  String title;
  List<FoodItem> _foodItems = [];

  UnmodifiableListView<FoodItem> get foodItems => UnmodifiableListView(_foodItems);

  UserList(this.title);

  

  int get totalItems => _foodItems.length;

  void add(FoodItem item) {
    _foodItems.add(item);
  }

  void removeAll() {
    _foodItems.clear();
  }

}