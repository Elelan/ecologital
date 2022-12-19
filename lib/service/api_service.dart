import 'dart:convert';

import 'package:ecologital/data/item.dart';
import "package:http/http.dart" as http;

import '../app/constants.dart';
import '../data/category.dart';
import 'models/order_response.dart';

class ApiService {
  var headers = {'api-key': Constants.apiKey};

  Future<List<Category>> fetchCategories() async {
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

  Future<List<Item>> fetchItems({String categoryId = "", int page = 1}) async {
    String url;
    if (categoryId != "") {
      url = "${Constants.baseUrl}/items?page=$page&category_id=$categoryId";
    } else {
      url = "${Constants.baseUrl}/items?page=$page";
    }
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final items = json.map((item) => Item.fromJson(item)).toList();
      return items;
    }
    return [];
  }

  Future<OrderResponse?> placeOrder(String id) async {
    const url = "${Constants.baseUrl}/placeorder";
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(<String, String>{
        'id': id,
      }),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return OrderResponse.fromJson(json);
    }
    return null;
  }
}
