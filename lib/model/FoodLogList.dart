import 'dart:collection';

import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:flutter/foundation.dart';

import '../util/database_helper.dart';

class FoodLogProvider with ChangeNotifier {
  DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Internal, private state of the cart.
  final List<FoodLog> _items = [];

  // int mode = 0;

  // void setMode(mode) {
  //   mode = 0;
  //   notifyListeners();
  // }

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

  Future<void> add(FoodLog item) async {
    int id = await _dbHelper.insertFoodLog(item);
    item.id = id;
    _items.add(item);
    notifyListeners();
  }

  void update(FoodLog item) {
    final target = _items.firstWhere((element) => element.id == item.id);
    final updateIndex = _items.indexOf(target);

    _items[updateIndex].id = item.id;
    _items[updateIndex].calories = item.calories;
    _items[updateIndex].date = item.date;
    _items[updateIndex].foodName = item.foodName;
    _items[updateIndex].photo = item.photo;
    _dbHelper.updateFoodLog(item);
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
