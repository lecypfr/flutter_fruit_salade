import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/providers/cart_provider.dart';
import 'package:tp_fruit/providers/fruits_provider.dart';
import 'package:tp_fruit/providers/user_provider.dart';
import 'package:tp_fruit/screen/market_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FruitsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
