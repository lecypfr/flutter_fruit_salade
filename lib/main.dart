import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/screen/market_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FruitMaster(),
    );
  }
}
