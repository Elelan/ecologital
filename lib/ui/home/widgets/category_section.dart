import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../data/category.dart';
import '../../../utils/theme.dart';

class CategorySection extends StatelessWidget {
  CategorySection({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: 100.0,
      child: controller.categoryLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.accentColor,),)
          : controller.categoryList.isEmpty
          ? const Center(child: Text("No data found"),)
          : ListView.separated(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.categoryList.length,
        itemBuilder: (context, index) {
          Category cat = controller.categoryList[index];
          return Chip(
            avatar: Image.network(
              cat.image,
              color: Colors.white,
            ),
            label: Text(cat.name),
            backgroundColor: AppTheme.accentColor,
            padding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 16),
            labelStyle: AppTheme.buildAppTheme()
                .textTheme
                .labelMedium,
          );
        },
      )
      ,
    ));
  }
}
