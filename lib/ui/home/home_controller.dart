import 'package:ecologital/app/constants.dart';
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

  // Used to display loading indicators when _firstLoad function is running
  final _isFirstLoadRunning = false.obs;

  bool get isFirstLoadRunning => _isFirstLoadRunning.value;

  // There is next page or not
  final _hasNextPage = true.obs;

  bool get hasNextPage => _hasNextPage.value;

  // Used to display loading indicators when _loadMore function is running
  final _isLoadMoreRunning = false.obs;

  bool get isLoadMoreRunning => _isLoadMoreRunning.value;

  final scrollController = ScrollController();

  var categoryList =
      List<Category>.generate(1, (index) => Constants.homeCategory).obs;

  Item? selectedItem;

  var selectedCategoryId = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchItems();

    selectedCategoryId.listen((value) {
      print("category id updated : $value");
    });
  }



  void fetchCategories() async {
    _categoryLoading.value = true;
    var fetchedCategories = await api.fetchCategories();
    categoryList.addAll(fetchedCategories);
    _categoryLoading.value = false;
  }

  void initCategories(String categoryId) {
    fetchFirstItemListForCategory(categoryId);
    paginateItems(categoryId);
  }

  void fetchItems() async {
    fetchFirstItemListForCategory("");
    paginateItems("");
  }

  List<Item> getItemsByCategory(String categoryId) {
    return categoryList
            .firstWhereOrNull((category) => category.id == categoryId)
            ?.itemList ??
        [];
  }

  void fetchFirstItemListForCategory(String categoryId) async {
    categoryList[getCategoryIndex(categoryId)].page(1);
    _isFirstLoadRunning(true);
    var itemsForCategory =
        await api.fetchItems(categoryId: categoryId, page: 1);
    if (itemsForCategory.isNotEmpty) {
      var index =
          categoryList.indexWhere((element) => element.id == categoryId);
      categoryList[index].itemList.addAll(itemsForCategory);
    } else {
      _hasNextPage(false);
    }
    _isFirstLoadRunning(false);
  }

  void fetchMoreItemListForCategory(String categoryId) async {
    if (hasNextPage &&
        !isFirstLoadRunning &&
        !isLoadMoreRunning &&
        scrollController.position.extentAfter < 300) {
      {
        _isLoadMoreRunning(true);
        var currentPage = getCurrentPage(categoryId);
        var nextPage =
            categoryList[getCategoryIndex(categoryId)].page(currentPage + 1);

        var moreItems =
            await api.fetchItems(categoryId: categoryId, page: nextPage);

        if (moreItems.isNotEmpty) {
          addItemsToCategory(categoryId, moreItems);
        } else {
          _hasNextPage(false);
        }
        _isLoadMoreRunning(false);
      }
    }
  }

  int getCategoryItemCount(String categoryId) =>
      categoryList[getCategoryIndex(categoryId)].itemList.length;

  void addItemsToCategory(String categoryId, List<Item> items) {
    var categoryIndex =
        categoryList.indexWhere((element) => element.id == categoryId);
    categoryList[categoryIndex].itemList.addAll(items);
  }

  void paginateItems(String categoryId) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMoreItemListForCategory(categoryId);
      }
    });
  }

  int getCategoryIndex(String id) =>
      categoryList.indexWhere((element) => element.id == id);

  int getCurrentPage(String categoryId) =>
      categoryList[getCategoryIndex(categoryId)].page.value;

  void navigateToDetail(String id) {
    navigateToDetailFromCategory(selectedCategoryId.value, id);
  }

  void navigateToDetailFromCategory(String categoryId, String id) {
    var category = categoryList.firstWhereOrNull((category) => category.id == categoryId);
    var item = category?.itemList.firstWhereOrNull((item) => item.id == id);
    if (item != null) {
      selectedItem = item;
      var args = {"categoryId": categoryId};
      String route = DetailsPage.getRouteName(id);
      Get.toNamed(route, arguments: args);
    } else {
      showSnackBar("Not found", "Item details not found", Colors.red);
    }
  }

  void updateFavourite(String itemId, bool favourite) {
    var categoryIndex = categoryList
        .indexWhere((category) => category.id == selectedCategoryId.value);
    var itemIndex = categoryList[categoryIndex]
        .itemList
        .indexWhere((item) => item.id == itemId);
    categoryList[categoryIndex].itemList[itemIndex].isFavourite(!favourite);
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
}
