import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/constants.dart';
import '../../utils/theme.dart';
import 'home_controller.dart';
import 'widgets/app_bar_row.dart';
import 'widgets/category_section.dart';
import 'widgets/list_item.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";

  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    controller.selectedCategoryId("");
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 16),
            sliver: SliverAppBar(
              elevation: 0,
              title: AppBarRow(),
              titleSpacing: 16,
              backgroundColor: Colors.white,
              // pinned: true,
              floating: true,
              snap: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Category",
                    style: AppTheme.titleStyle,
                  ),
                  CategorySection(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: AppTheme.bgColor,
                child: Obx(() {
                  if (controller.isFirstLoadRunning) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.accentColor,
                      ),
                    );
                  }
                  if (controller
                      .getItemsByCategory(Constants.homeCategoryId)
                      .isEmpty) {
                    return const Center(
                      child: Text(
                        "No data",
                        style: TextStyle(color: Colors.black),
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
                          itemCount: controller
                              .getCategoryItemCount(Constants.homeCategoryId),
                          itemBuilder: (context, index) => ListItem(
                                item: controller
                                    .categoryList[controller.getCategoryIndex(
                                        Constants.homeCategoryId)]
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
                })),
          ),
        ],
      ),
    );
  }
}
