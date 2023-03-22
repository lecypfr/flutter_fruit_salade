import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruit/class/cart.dart';
import 'package:tp_fruit/widget/fruit_preview.dart';

class CartState extends StatefulWidget {
  const CartState({super.key});

  @override
  State<CartState> createState() => _CartStateState();
}

class _CartStateState extends State<CartState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CartModel>(builder: (context, cart, child) {
          return Text('Total panier ${cart.totalPriceFormat()}');
        }),
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<CartModel>(context, listen: false).removeAll(),
            icon: const Icon(Icons.remove_shopping_cart),
          )
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView(
            children: cart.items
                .map((cartItem) => FruitPreview(
                      fruit: cartItem.fruit,
                      buttonTrailingIsDelete: true,
                      quantity: cartItem.quantity,
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
