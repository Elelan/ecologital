import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {

  static const routeName = "/cart";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("cart page"),
      ),
    );
  }
}