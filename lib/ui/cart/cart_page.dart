import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {

  static const routeName = "/cart";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("cart page"),
      ),
    );
  }
}