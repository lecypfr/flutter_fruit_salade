import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tp_fruit/class/fruit.dart';

class FruitsModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<Fruit> _content = [];
  String seasonSelected = "";
  // double get totalPrice =>
  // _content.map((fruit) => fruit.price).reduce((a, b) => a + b);

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Fruit> get fruits {
    if (seasonSelected == '') {
      return UnmodifiableListView(_content);
    } else {
      List<Fruit> temp = [];
      for (var fruit in _content) {
        if (fruit.season == seasonSelected) {
          temp.add(fruit);
        }
      }
      return UnmodifiableListView(temp);
    }
  }

  /// The current total price of all items (assuming all items cost $42).

  void set(List<Fruit> fruits) {
    _content = fruits;
    notifyListeners();
  }

  void editSeasonFilter(String newSeasonSelected) {
    seasonSelected = newSeasonSelected;
    notifyListeners();
  }
}
