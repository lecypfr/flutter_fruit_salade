import 'dart:convert';
import 'dart:js_util';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:tp_fruit/class/fruits.dart';
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
          Provider.of<FruitsModel>(context, listen: false).set(snapshot.data);
          return Scaffold(
            appBar: AppBar(
                title: Consumer<CartModel>(builder: (context, model, child) {
              return Text('Total panier ${model.totalPriceFormat()}');
            })),
            body: Column(children: [
              Row(children: [
                Consumer<FruitsModel>(builder: (context, model, child) {
                  return DropdownButton(
                    value: model.seasonSelected,
                    items: const [
                      DropdownMenuItem(value: "", child: Text("Tous")),
                      DropdownMenuItem(
                          value: "Printemps", child: Text("Printemps")),
                      DropdownMenuItem(value: "Eté", child: Text("Été")),
                      DropdownMenuItem(
                          value: "Automne", child: Text("Automne")),
                      DropdownMenuItem(value: "Hiver", child: Text("Hiver")),
                    ],
                    onChanged: (newSeasonSelected) =>
                        Provider.of<FruitsModel>(context, listen: false)
                            .editSeasonFilter(newSeasonSelected!),
                  );
                }),
              ]),
              Flexible(child:
                  Consumer<FruitsModel>(builder: (context, model, child) {
                // return Text(cart.seasonSelected);
                return ListView(
                  children: model.fruits
                      .map((fruit) => FruitPreview(fruit: fruit))
                      .toList(),
                );
              }))
            ]),
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
