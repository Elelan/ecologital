import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {

  static const routeName = "/category";

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("category page"),
      ),
    );
  }
}