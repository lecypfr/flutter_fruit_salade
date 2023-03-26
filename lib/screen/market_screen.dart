import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tp_fruit/providers/cart_provider.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:tp_fruit/providers/fruits_provider.dart';
import 'package:tp_fruit/screen/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/screen/log_in_screen.dart';
import 'package:tp_fruit/widget/fruit_preview.dart';
import 'package:tp_fruit/widget/season_filter.dart';

class FruitMaster extends StatefulWidget {
  FruitMaster({super.key});

  final List<Fruit> fruits = [];

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  String seasonSelected = "";

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
          Provider.of<FruitsProvider>(context, listen: false)
              .set(snapshot.data);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()),
                      ),
                  icon: const Icon(Icons.account_circle_outlined)),
              title: Consumer<CartProvider>(builder: (context, model, child) {
                return Text('Total panier ${model.totalPriceFormat()}');
              }),
            ),
            body: Column(
              children: [
                Row(
                  children: const [
                    SeasonFilter(),
                  ],
                ),
                Flexible(
                  child: Consumer<FruitsProvider>(
                      builder: (context, model, child) => ListView(
                            children: model.fruits
                                .map((fruit) => FruitPreview(fruit: fruit))
                                .toList(),
                          )),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartState()),
              ),
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
