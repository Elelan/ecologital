import 'dart:convert';
import 'package:ecologital/data/item.dart';
import "package:http/http.dart" as http;

import '../app/constants.dart';
import '../data/category.dart';

class ApiService {
  static Future<List<Category>> fetchCategories() async {
    var headers = {'api-key': Constants.apiKey};
    const url = "${Constants.baseUrl}/categories";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final categories = json.map((item) => Category.fromJson(item)).toList();
      return categories;
    }
    return [];
  }

  Future<List<Item>> fetchItems() async {
    var headers = {'api-key': Constants.apiKey};
    const url = "${Constants.baseUrl}/items";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final items = json.map((item) => Item.fromJson(item)).toList();
      return items;
    }
    return [];
  }
}
