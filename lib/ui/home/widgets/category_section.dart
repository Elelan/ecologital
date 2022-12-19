import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/category.dart';
import '../../../utils/theme.dart';
import '../../category/category_page.dart';
import '../home_controller.dart';

class CategorySection extends StatelessWidget {
  CategorySection({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 60.0,
          child: controller.categoryLoading
              ? const Center(
                  child: LinearProgressIndicator(
                    color: AppTheme.accentColor,
                  ),
                )
              : controller.categoryList.isEmpty
                  ? const Center(
                      child: Text("No data found"),
                    )
                  : ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categoryList.length - 1,
                    itemBuilder: (context, index) {
                      Category cat = controller.categoryList[index + 1];
                      return ActionChip(
                        elevation: 8.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        avatar: CachedNetworkImage(
                          imageUrl: cat.image,
                          color: Colors.white,
                        ),
                        label: Text(
                          cat.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          var data = {
                            "categoryName": cat.name
                          };
                          Get.toNamed(CategoryPage.getCategoryRoute(cat.id),
                              parameters: data);
                        },
                        backgroundColor: AppTheme.accentColor,
                      );
                    },
                  ),
        ));
  }
}
