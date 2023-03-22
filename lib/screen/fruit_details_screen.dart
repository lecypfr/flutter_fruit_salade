import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tp_fruit/widget/quantity_badge.dart';

class FruitDetailsScreen extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailsScreen({super.key, required this.fruit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the FruitMaster object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(fruit.name),
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<CartModel>(context, listen: false).remove(fruit),
              icon: const Icon(Icons.remove_shopping_cart))
        ],
      ),
      body: Column(children: [
        Card(
            child: Row(
          children: [
            Flexible(child: Image.asset("images/${fruit.name}.png")),
            Consumer<CartModel>(builder: (context, model, child) {
              return QuantityBadge(quantity: model.quantityOf(fruit));
            })
          ],
        )),
        Expanded(
            child: FlutterMap(
          options: MapOptions(
            center: LatLng(fruit.origin.location.coordinates[1],
                fruit.origin.location.coordinates[0]),
            zoom: 4,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
              maxZoom: 20,
              subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: LatLng(fruit.origin.location.coordinates[1],
                      fruit.origin.location.coordinates[0]),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<CartModel>(context, listen: false).add(fruit),
        tooltip: 'Increment',
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
