import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {

  static const routeName = "/detail";

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("details page"),
      ),
    );
  }
}
