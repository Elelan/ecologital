import 'package:flutter/material.dart';

import '../ui/home/home_page.dart';

class MyStoreApp extends StatelessWidget {
  MyStoreApp({Key? key}) : super(key: key);

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
