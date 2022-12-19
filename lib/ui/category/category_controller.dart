import 'package:ecologital/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/item.dart';
import '../details/details_page.dart';

class CategoryController extends GetxController {
  final api = Get.find<ApiService>();
  ScrollController scrollController = ScrollController();

  final _page = 1.obs;

  int get page => _page.value;
  var isMoreDataAvailable = true.obs;
  var isDataProcessing = false.obs;
  var fetchingMoreDta = false.obs;

  final _categoryId = "".obs;

  String get categoryId => _categoryId.value;
  final itemList = List<Item>.empty().obs;
  Item? selectedItem;

  @override
  void onReady() {
    super.onReady();
    String? categoryId = Get.parameters['categoryId'];
    String? categoryName = Get.parameters['categoryName'];

    // Fetch Data
    getTask(categoryId!, page);

    //For Pagination
    paginateTask();
  }

  Item getItemById(String id) {
    return itemList.firstWhere((element) => element.id==id);
  }

  // Fetch Data
  void getTask(String categoryId, int page) async {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);

      itemList.value = await api.fetchItems(categoryId: categoryId, page: page);

      isDataProcessing(false);
    } catch (exception) {
      isDataProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  // Refresh List
  void refreshList() async {
    _page.value = 1;
    getTask(categoryId, page);
  }

  // Get More data
  void getMoreTask(int page) async {
    try {
      fetchingMoreDta(true);
      var newList = await api.fetchItems(categoryId: categoryId, page: page);
      if(newList.isNotEmpty) {
        isMoreDataAvailable(true);
      } else {
        isMoreDataAvailable(false);
        showSnackBar("Message", "No more items", Colors.lightBlueAccent);
      }
      itemList.addAll(newList);
      fetchingMoreDta(false);
    } catch (exception) {
      isMoreDataAvailable(false);
      fetchingMoreDta(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  // For Pagination
  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        _page.value++;
        getMoreTask(page);
      }
    });
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
