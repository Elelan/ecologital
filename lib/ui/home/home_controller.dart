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

  var categoryList = List<Category>.empty().obs;

  final _itemLoading = false.obs;

  bool get itemLoading => _itemLoading.value;
  var itemList = List<Item>.empty().obs;
  Item? selectedItem;

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

  void initCategories(String categoryId) {
    fetchFirstItemListForCategory(categoryId);
    paginateItems(categoryId);
  }

  void fetchItems() async {
    _itemLoading.value = true;
    itemList.value = await api.fetchItems();
    _itemLoading.value = false;
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

        print("currentPage: $currentPage");
        print("nextPage: $nextPage");
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

  Item getItemById(String id) {
    return itemList.firstWhere((element) => element.id == id);
  }

  void navigateToDetail(String id) {
    selectedItem = getItemById(id);
    String route = DetailsPage.getRouteName(id);
    Get.toNamed(route);
  }

  void updateFavourite(Item item, bool favourite) {
    var index = itemList.indexWhere((element) => element.id == item.id);
    itemList[index].isFavourite.toggle();
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
}
