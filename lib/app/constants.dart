import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/category.dart';

class Constants {

  Constants._();

  static const homeCategoryId = "";
  static Category homeCategory = Category(id: Constants.homeCategoryId, name: "", image: "");

  static const snackbarDuration = Duration(seconds: 4);
//colors
  static const appBarBackgroundColor = Color(0xFFC2DEEE);
  static const appBarTextColor = Color(0xFF020000);
  static const linearProgressIndicatorColor =
      Color.fromARGB(255, 225, 236, 241);

//endpoints
  static const itemsURL = "assets/data/items.json";
  static const categoriesURL = "assets/data/categories.json";

// apiKey
  static const baseUrl = "https://data.mongodb-api.com/app/data-kdspl/endpoint";
  static const apiKey =
      "6GcIgLqKZBT2bxZr9uwIhuZDlOlulxKUMHc89S4VRPzoMkvrxZ5BW6T0wlLMwMQL";

  static var currencyFormatter =
      NumberFormat.currency(locale: 'en-US', decimalDigits: 2);
}
