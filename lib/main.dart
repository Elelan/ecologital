import 'package:ecologital/ui/home/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'service/api_service.dart';
import 'ui/cart/cart_page.dart';
import 'ui/category/category_page.dart';
import 'ui/details/details_page.dart';
import 'ui/home/home_page.dart';
import 'utils/theme.dart';

void main() async{
  await GetStorage.init();
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
        initialRoute: HomePage.routeName,
        initialBinding: HomeBinding(),
        getPages: [
          GetPage(name: HomePage.routeName, page: () => HomePage()),
          GetPage(name: CartPage.routeName, page: () => CartPage()),
          GetPage(name: CategoryPage.routeName, page: () => CategoryPage()),
          GetPage(name: DetailsPage.routeName, page: () => DetailsPage())
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
