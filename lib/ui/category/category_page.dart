import 'package:ecologital/ui/category/category_controller.dart';
import 'package:ecologital/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../home/widgets/list_item.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = "/category/:categoryId";

  static String getCategoryRoute(String id) => "/category/$id";

  CategoryPage({Key? key}) : super(key: key);

  final controller = Get.put(CategoryController());
  final homeController = Get.find<HomeController>();

  String? categoryId = Get.parameters['categoryId'];
  String? categoryName = Get.parameters['categoryName'];

  @override
  Widget build(BuildContext context) {
    controller.initCategories(categoryId!);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName!),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textColorDark,
        elevation: 0,
      ),
      body: CustomScrollView(
        controller: controller.scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Obx(() {
              if (categoryId == null) {
                return const Center(
                  child: Text("Category not found"),
                );
              }

              if (controller.isFirstLoadRunning) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.accentColor,
                  ),
                );
              }
              return Column(
                children: [
                  ListView.separated(
                      // controller: controller.scrollController,
                      padding: const EdgeInsets.only(top: 8),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 6,
                          ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          homeController.getCategoryItemCount(categoryId!),
                      itemBuilder: (context, index) => ListItem(
                            item: homeController
                                .categoryList[homeController
                                    .getCategoryIndex(categoryId!)]
                                .itemList[index],
                          )),

                  // when the _loadMore function is running
                  if (controller.isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (controller.hasNextPage == false)
                    const Center(
                      child: Text('Reached the end'),
                    ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
