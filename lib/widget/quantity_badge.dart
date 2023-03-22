import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget {
  final int quantity;

  const QuantityBadge({super.key, required this.quantity});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (quantity != 0) {
      return Chip(
        backgroundColor: Colors.deepPurple,
        label: Text(quantity.toString(),
            style: const TextStyle(color: Colors.white)),
      );
    } else {
      return Container();
    }
  }
}
