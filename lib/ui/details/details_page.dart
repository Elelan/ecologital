import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../home/home_controller.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/detail/:id";

  static String getRouteName(String id) => "/detail/${id}";

  DetailsPage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  final selectedUnitIndex = 0.obs;
  final itemNumber = 1.obs;

  @override
  Widget build(BuildContext context) {

    if(Get.parameters["id"] == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.selectedItem == null) {
      controller.showSnackBar(
          "Not found", "Details of item not found", Colors.redAccent);
      Get.back();
    }

    var amount = controller.selectedItem!.price.toStringAsFixed(2);
    var unitTypes = controller.selectedItem!.unitType;

    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.bgColor,
              pinned: false,
              stretch: false,
              floating: true,
              expandedHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              collapsedHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: CachedNetworkImage(
                  imageUrl: controller.selectedItem!.image,
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size(0, 20),
                  child: Transform.translate(
                    offset: const Offset(0, 1),
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                          color: AppTheme.bgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Center(
                        child: Container(
                          height: 6,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.55,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.selectedItem!.name,
                              style: AppTheme.titleStyle,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.updateFavourite(
                                    controller.selectedItem!,
                                    controller.selectedItem!.isFavourite.value);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.zero,
                                backgroundColor: AppTheme.accentColor,
                                // <-- Button color
                                foregroundColor:
                                AppTheme.bgColor, // <-- Splash color
                              ),
                              child: Obx(() =>
                                  Icon(
                                      controller.selectedItem!.isFavourite.value
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: AppTheme.bgColor)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          // runSpacing: 8,
                          spacing: 6,
                          alignment: WrapAlignment.start,
                          children: List<Widget>.generate(
                              unitTypes != null ? unitTypes.length : 0,
                                  (index) =>
                                  Obx(() {
                                    var unit =
                                    controller.selectedItem!.unitType![index];
                                    var chipSelected =
                                        selectedUnitIndex.value == index;
                                    return ChoiceChip(
                                        onSelected: (isSelected) {
                                          if (isSelected) {
                                            selectedUnitIndex(index);
                                          }
                                        },
                                        selectedColor: AppTheme.accentColor,
                                        label: Text(
                                          unit.value,
                                          style: TextStyle(
                                              color: chipSelected
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        selected: chipSelected);
                                  })).toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs $amount",
                              style: AppTheme.moneyStyle,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RoundedIconButton(
                                    icon: Icons.remove,
                                    onPress: () {
                                      if (itemNumber.value > 0) {
                                        itemNumber(itemNumber.value - 1);
                                      }
                                    },
                                    iconSize: 36,
                                    fillColor: Colors.grey.shade300,
                                    iconColor: Colors.black,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Obx(() =>
                                        Text(
                                          "${itemNumber.value}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  RoundedIconButton(
                                    icon: Icons.add,
                                    onPress: () {
                                      itemNumber(itemNumber.value + 1);
                                    },
                                    iconSize: 36,
                                    fillColor: AppTheme.accentColor,
                                    iconColor: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Divider(
                          height: 3,
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Description",
                          style: AppTheme.titleStyle,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Flexible(
                          child: Text(
                            controller.selectedItem!.description,
                            style: TextStyle(
                                height: 1.5,
                                color: AppTheme.textColor.withOpacity(0.8)),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          height: 50,
                          elevation: 0,
                          color: AppTheme.accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({super.key,
    required this.icon,
    required this.onPress,
    required this.iconSize,
    required this.fillColor,
    required this.iconColor});

  final IconData icon;
  final void Function()? onPress;
  final double iconSize;
  final Color fillColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      onPressed: onPress,
      padding: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize * 0.2)),
      fillColor: fillColor,
      elevation: 0,
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize * 0.6,
      ),
    );
  }
}
