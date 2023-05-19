import 'dart:collection';

import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:flutter/foundation.dart';

import '../util/database_helper.dart';

class FoodLogProvider with ChangeNotifier {
  DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Internal, private state of the cart.
  final List<FoodLog> _items = [];

  // Future loadList() async {
  //   // // List<FoodLog> dbFoodLogList = await _dbHelper.fetchFoodLogs();
  //   // // _items.clear();
  //   // List<FoodLog> dbItems = await _dbHelper.fetchFoodLogs();
  //   // for (var element in dbItems) {
  //   //   _items.add(element);
  //   // }
  //   // return _items;
  // }

  FoodLogProvider() {
    _dbHelper.fetchFoodLogs().then((value) => {addAll(value)});
  }

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<FoodLog> get items => UnmodifiableListView(_items);

  int get length => _items.length;

  void add(FoodLog item) {
    _items.add(item);
    _dbHelper.insertFoodLog(item);
    notifyListeners();
  }

  FoodLog operator [](int index) {
    return _items[index];
  }

  void addAll(List<FoodLog> items) {
    for (var item in items) {
      _items.add(item);
    }
    notifyListeners();
  }

  // void removeAll() {
  //   _items.clear();
  //   notifyListeners();
  // }

  Future<void> remove(int id) async {
    _items.removeWhere((element) => element.id == id);
    _dbHelper.deleteFoodLog(id);
    notifyListeners();
  }
}
