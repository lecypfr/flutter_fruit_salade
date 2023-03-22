import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:tp_fruit/screen/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/widget/fruit_preview.dart';

class FruitMaster extends StatefulWidget {
  FruitMaster({super.key});

  final List<Fruit> fruits = [];

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  int pageIndex = 0;

  Future getFruit() async {
    final response = await http
        .get(Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*'));
    final json = jsonDecode(response.body);

    List<Fruit> fruits = [];
    for (var fruit in json['data']) {
      fruits.add(Fruit.fromJson(fruit));
    }
    return fruits;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFruit(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Fruit> fruits = snapshot.data;
          return Scaffold(
            appBar: AppBar(
                title: Consumer<CartModel>(builder: (context, cart, child) {
              return Text('Total panier ${cart.totalPriceFormat()}');
            })),
            body: ListView(
              children:
                  fruits.map((fruit) => FruitPreview(fruit: fruit)).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartState())),
              tooltip: 'Nouveau fruit',
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Column(
            children: const [
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}
