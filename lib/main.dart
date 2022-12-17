
import 'package:ecologital/providers/category_provider.dart';
import 'package:ecologital/ui/cart/cart_page.dart';
import 'package:ecologital/ui/category/category_page.dart';
import 'package:ecologital/ui/home/home_page.dart';
import 'package:ecologital/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final api = Get.put(ApiService());
    return Theme(
      data: AppTheme.buildAppTheme(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // home: Theme(
        //     data: AppTheme.buildAppTheme(),
        //     child: MyStoreApp()
        // ),
        initialRoute: HomePage.routeName,
        getPages: [
          GetPage(name: HomePage.routeName, page: () => HomePage()),
          GetPage(name: CartPage.routeName, page: () => CartPage()),
          GetPage(name: CategoryPage.routeName, page: () => CategoryPage())
        ],
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