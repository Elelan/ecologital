import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import '../../utils/theme.dart';
import 'widgets/app_bar_row.dart';
import 'widgets/category_section.dart';
import 'widgets/item_section.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";

  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),
        slivers: [
          SliverPadding(padding: const EdgeInsets.only(bottom: 16),
          sliver: SliverAppBar(
            elevation: 0,
            title: AppBarRow(),
            titleSpacing: 16,
            backgroundColor: Colors.white,
            // pinned: true,
            floating: true,
            snap: true,
          ),),

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
            child: ItemSection(),
          ),
        ],
      ),
    );
  }
}
