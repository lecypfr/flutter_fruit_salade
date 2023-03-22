import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/class/fruit.dart';
import 'package:tp_fruit/screen/fruit_details_screen.dart';
import 'package:money_formatter/money_formatter.dart';
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
    MoneyFormatter fmf = MoneyFormatter(
        amount: fruit.price, settings: MoneyFormatterSettings(symbol: '€'));

    return ListTile(
      leading: Image.asset("images/${fruit.image}"),
      title: Text(fruit.name),
      subtitle: quantity == 0
          ? Text(fmf.output.symbolOnRight)
          : Text("${fmf.output.symbolOnRight} | Dans votre panier : $quantity"),
      tileColor: fruit.color,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FruitDetailsScreen(fruit: fruit))),
      trailing: Wrap(
        children: [
          const QuantityBadge(),
          buttonTrailingIsDelete
              ? IconButton(
                  onPressed: () =>
                      Provider.of<CartModel>(context, listen: false)
                          .remove(fruit),
                  icon: const Icon(Icons.remove_shopping_cart),
                )
              : IconButton(
                  onPressed: () =>
                      Provider.of<CartModel>(context, listen: false).add(fruit),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
        ],
      ),
    );
  }
}
