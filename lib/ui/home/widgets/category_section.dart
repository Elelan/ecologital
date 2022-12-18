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
          height: 100.0,
          child: controller.categoryLoading
              ? const Center(
                  child: CircularProgressIndicator(
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
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        Category cat = controller.categoryList[index];
                        return ActionChip(
                          elevation: 8.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
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
                              "categoryId": cat.id,
                              "categoryName": cat.name
                            };
                            Get.toNamed(CategoryPage.routeName,
                                parameters: data);
                          },
                          backgroundColor: AppTheme.accentColor,
                          // shape: StadiumBorder(
                          //     side: BorderSide(
                          //       width: 1,
                          //       color: Colors.redAccent,
                          //     )),
                        );
                        // return ActionChip(
                        //   avatar: Image.network(
                        //     cat.image,
                        //     color: Colors.white,
                        //   ),
                        //   label: Text(cat.name),
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 12, horizontal: 16),
                        //   labelStyle: AppTheme.buildAppTheme()
                        //       .textTheme
                        //       .labelMedium,
                        // );
                      },
                    ),
        ));
  }
}
