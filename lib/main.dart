import 'package:ecologital/utils/theme.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Theme(
          data: AppTheme.buildAppTheme(),
          child: MyStoreApp()
      ),
    );
  }
}

class SearchNotifier with ChangeNotifier {
  List<String> searchList = ["apple", "orange", "banana"];

  Future<List<String>> search(String query) async {
    return await searchList
        .where((element) => element.contains(query))
        .toList(growable: false);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}