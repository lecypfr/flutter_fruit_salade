import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/class/cart_item.dart';
import 'package:tp_fruit/class/fruit.dart';

class QuantityBadge extends StatelessWidget {
  final Fruit fruit;

  const QuantityBadge({super.key, required this.fruit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      if (cart.items.any((cartItem) => cartItem.fruit == fruit)) {
        return Chip(
          backgroundColor: Colors.deepPurple,
          label: Text(
              cart
                  .items[cart.items
                      .indexWhere((element) => element.fruit == fruit)]
                  .quantity
                  .toString(),
              style: const TextStyle(color: Colors.white)),
        );
      } else {
        return const Chip(
          backgroundColor: Colors.deepPurple,
          label: Text(' ', style: const TextStyle(color: Colors.white)),
        );
      }
    });
  }
}
