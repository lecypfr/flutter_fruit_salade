import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/fruit.dart';

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Badge(
      child: Text('OUI'),
    );
  }
}
