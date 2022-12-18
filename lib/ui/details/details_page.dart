import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../home/home_controller.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/detail";

  DetailsPage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    if (controller.selectedItem == null) {
      controller.showSnackBar(
          "Not found", "Details of item not found", Colors.redAccent);
      Get.back();
    }
    return Scaffold(
        backgroundColor: AppTheme.bgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.bgColor,
              bottom: PreferredSize(
                  preferredSize: const Size(0, 20), child: Container()),
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              collapsedHeight: MediaQuery.of(context).size.height * 0.1,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CachedNetworkImage(
                      imageUrl: controller.selectedItem!.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                          color: AppTheme.bgColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50))),
                    ),
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("---")],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedItem!.name,
                            style: AppTheme.titleStyle,
                          ),
                          // IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline))
                          ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.favorite_outline,
                                color: AppTheme.bgColor),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                              backgroundColor: AppTheme.accentColor,
                              // <-- Button color
                              foregroundColor:
                                  AppTheme.bgColor, // <-- Splash color
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: controller.selectedItem?.unitType != null
                      ? Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 8,
                        alignment: WrapAlignment.start,
                        children: List<Widget>.generate(
                            controller.selectedItem!.unitType!.length,
                                (index) => ChoiceChip(label: Text("label"), selected: false)).toList(),
                      )
                      : Text("no units"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs ${controller.selectedItem!.price.toStringAsFixed(2)}",
                            style: AppTheme.moneyStyle,
                          ),
                          Container(
                            child: Row(
                              children: [Text("-"), Text("1"), Text("+")],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        height: 3,
                        thickness: 3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: AppTheme.titleStyle,
                        ),
                      ],
                    ),
                    Flexible(
                        child:
                            Text(controller.selectedItem!.description, style: AppTheme.bodyStyle))
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Add to cart'),
            style: ElevatedButton.styleFrom(
                primary: AppTheme.accentColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
        ));
  }
}
