import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/providers/cart_provider.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:tp_fruit/screen/fruit_details_screen.dart';
import 'package:tp_fruit/widget/quantity_badge.dart';

class FruitPreview extends StatelessWidget {
  final bool buttonTrailingIsDelete;
  final Fruit fruit;
  final int quantity;

  const FruitPreview(
      {super.key,
      this.buttonTrailingIsDelete = false,
      required this.fruit,
      this.quantity = 0});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("images/${fruit.image}"),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(fruit.name),
          Consumer<CartProvider>(builder: (context, model, child) {
            return QuantityBadge(quantity: model.quantityOf(fruit));
          })
        ],
      ),
      tileColor: fruit.color,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FruitDetailsScreen(fruit: fruit))),
      trailing: buttonTrailingIsDelete
          ? IconButton(
              onPressed: () => Provider.of<CartProvider>(context, listen: false)
                  .remove(fruit),
              icon: const Icon(Icons.remove_shopping_cart),
            )
          : IconButton(
              onPressed: () =>
                  Provider.of<CartProvider>(context, listen: false).add(fruit),
              icon: const Icon(Icons.add_shopping_cart),
            ),
    );
  }
}
