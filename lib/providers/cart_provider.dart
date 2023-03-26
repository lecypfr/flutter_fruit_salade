import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:tp_fruit/class/cart_item.dart';
import 'package:tp_fruit/class/fruit.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<CartItem> _content = [];
  // double get totalPrice =>
  // _content.map((fruit) => fruit.price).reduce((a, b) => a + b);

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_content);

  /// The current total price of all items (assuming all items cost $42).

  void add(Fruit fruit) {
    if (_content.any((cartItem) => cartItem.fruit == fruit)) {
      _content[_content.indexWhere((element) => element.fruit == fruit)]
          .quantity++;
    } else {
      _content.add(CartItem(fruit: fruit, quantity: 1));
    }
    notifyListeners();
  }

  void remove(Fruit fruit) {
    if (_content[_content.indexWhere((element) => element.fruit == fruit)]
            .quantity ==
        1) {
      _content
          .removeAt(_content.indexWhere((element) => element.fruit == fruit));
    } else {
      _content[_content.indexWhere((element) => element.fruit == fruit)]
          .quantity--;
    }
    notifyListeners();
  }

  void removeAll() {
    _content.clear();
    notifyListeners();
  }

  int quantityOf(Fruit fruit) {
    if (_content.any((cartItem) => cartItem.fruit == fruit)) {
      return _content[_content.indexWhere((element) => element.fruit == fruit)]
          .quantity;
    } else {
      return 0;
    }
  }

  double totalPrice() {
    return _content
        .map((cartItem) => cartItem)
        .fold(0, (t, e) => t + (e.fruit.price * e.quantity));
  }

  String totalPriceFormat() {
    final double total = _content
        .map((cartItem) => cartItem)
        .fold(0, (t, e) => t + (e.fruit.price * e.quantity));
    MoneyFormatter totalFormat = MoneyFormatter(
        amount: total, settings: MoneyFormatterSettings(symbol: '€'));
    return totalFormat.output.symbolOnRight;
  }
}
