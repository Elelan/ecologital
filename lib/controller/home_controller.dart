import 'package:get/get.dart';

import '../data/category.dart';
import '../data/item.dart';
import '../service/api_service.dart';

class HomeController extends GetxController {
  final api = Get.put(ApiService());

  final _categoryLoading = false.obs;

  bool get categoryLoading => _categoryLoading.value;
  var categoryList = List<Category>.empty().obs;

  final _itemLoading = false.obs;

  bool get itemLoading => _itemLoading.value;
  var itemList = List<Item>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchItems();
  }

  void fetchCategories() async {
    _categoryLoading.value = true;
    await Future.delayed(const Duration(seconds: 4));
    categoryList.value = await ApiService.fetchCategories();
    _categoryLoading.value = false;
  }

  void fetchItems() async {
    _itemLoading.value = true;
    itemList.value = await api.fetchItems();
    _itemLoading.value = false;
  }
}
