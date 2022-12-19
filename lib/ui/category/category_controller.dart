import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/category.dart';
import '../../service/api_service.dart';
import '../home/home_controller.dart';

class CategoryController extends GetxController {
  final api = Get.find<ApiService>();
  final homeController = Get.find<HomeController>();

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

  void initCategories(String categoryId) {
    homeController.selectedCategoryId(categoryId);
    fetchFirstItemListForCategory(categoryId);
    paginateItems(categoryId);
  }

  void fetchFirstItemListForCategory(String categoryId) async {
    homeController.categoryList[homeController.getCategoryIndex(categoryId)]
        .page(1);
    _isFirstLoadRunning(true);
    var itemsForCategory =
        await api.fetchItems(categoryId: categoryId, page: 1);
    if (itemsForCategory.isNotEmpty) {
      var index = homeController.categoryList
          .indexWhere((element) => element.id == categoryId);
      homeController.categoryList[index].itemList.addAll(itemsForCategory);
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
        var currentPage = homeController.getCurrentPage(categoryId);
        var nextPage = homeController
            .categoryList[homeController.getCategoryIndex(categoryId)]
            .page(currentPage + 1);

        print("currentPage: $currentPage");
        print("nextPage: $nextPage");
        var moreItems =
            await api.fetchItems(categoryId: categoryId, page: nextPage);

        if (moreItems.isNotEmpty) {
          homeController.addItemsToCategory(categoryId, moreItems);
        } else {
          _hasNextPage(false);
        }
        _isLoadMoreRunning(false);
      }
    }
  }

  void paginateItems(String categoryId) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMoreItemListForCategory(categoryId);
      }
    });
  }
}
