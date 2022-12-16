import 'package:ecologital/service/api_service.dart';
import 'package:flutter/material.dart';

import '../data/category.dart';

class CategoryProvider with ChangeNotifier {
  final _apiService = ApiService();

  bool isCategoriesLoading = false;
  List<Category> _categoryList = [];

  List<Category> get categoryList => [..._categoryList];

  Future<void> fetchCategories() async {
    isCategoriesLoading = true;
    notifyListeners();

    // try {
    //   _categoryList = await _apiService.fetchCategories();
    //   isCategoriesLoading = false;
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    // }
  }
}
