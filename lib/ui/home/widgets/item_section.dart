import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../utils/theme.dart';
import 'list_item.dart';

class ItemSection extends StatelessWidget {
  ItemSection({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: AppTheme.bgColor,
        child: Obx(() => controller.itemLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.itemList.isEmpty
            ? const Center(
          child: Text("No data", style: TextStyle(color: Colors.black),),
        )
            : ListView.separated(
          padding: const EdgeInsets.only(top: 8),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: 6,
              // color: AppTheme.bgColor,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.itemList.length,
            itemBuilder: (context, index) =>
                ListItem(item: controller.itemList[index])))
    );
  }
}
