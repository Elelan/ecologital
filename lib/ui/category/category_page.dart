import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../home/widgets/list_item.dart';
import 'category_controller.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = "/category";

  CategoryPage({Key? key}) : super(key: key);

  final controller = Get.put(CategoryController());

  String? categoryId = Get.parameters['categoryId'];
  String? categoryName = Get.parameters['categoryName'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName!),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textColor,
        elevation: 0,
      ),
      body: Container(
        color: AppTheme.bgColor,
        child: Obx(() {
          if (categoryId == null) {
            return const Center(
              child: Text("Category not found"),
            );
          }

          if (controller.isDataProcessing.value == true) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.accentColor,
              ),
            );
          }
          return ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                    height: 6,
                    // color: AppTheme.bgColor,
                  ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.itemList.length,
              itemBuilder: (context, index) => ListItem(
                    item: controller.itemList[index],
                    onClick: () {},
                  ));
        }),
      ),
    );
  }
}
