import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/category.dart';
import '../../data/item.dart';
import '../../service/api_service.dart';
import '../details/details_page.dart';

class HomeController extends GetxController {
  final api = Get.find<ApiService>();

  final _categoryLoading = false.obs;

  bool get categoryLoading => _categoryLoading.value;
  var categoryList = List<Category>.empty().obs;

  final _itemLoading = false.obs;

  bool get itemLoading => _itemLoading.value;
  var itemList = List<Item>.empty().obs;
  Item? selectedItem;

  final _isSelectedFavourite = false.obs;
  bool get isSelectedFavourite => _isSelectedFavourite.value;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchItems();
  }

  void fetchCategories() async {
    _categoryLoading.value = true;
    categoryList.value = await api.fetchCategories();
    _categoryLoading.value = false;
  }

  void fetchItems() async {
    _itemLoading.value = true;
    itemList.value = await api.fetchItems();
    _itemLoading.value = false;
  }

  void navigateToDetail(Item itemSelected) {
    selectedItem = itemSelected;
    _isSelectedFavourite(itemSelected.isFavourite);
    Get.toNamed(DetailsPage.routeName);
  }

  void updateFavourite(Item item, bool favourite) {
    var index = itemList.indexWhere((element) => element.id == item.id);
    itemList[index].isFavourite = favourite;
    _isSelectedFavourite(favourite);
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
}
