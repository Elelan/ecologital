import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecologital/data/unit_type.dart';
import 'package:ecologital/ui/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../core/widgets/default_snackbar.dart';
import '../core/widgets/rounded_icon_button.dart';
import '../home/home_controller.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/detail/:id";

  static String getRouteName(String id) => "/detail/${id}";

  DetailsPage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();
  final cartController = Get.find<CartController>();

  final selectedUnitIndex = 0.obs;
  final itemNumber = 1.obs;

  @override
  Widget build(BuildContext context) {
    if (Get.parameters["id"] == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.selectedItem == null) {
      controller.showSnackBar(
          "Not found", "Details of item not found", Colors.redAccent);
      Get.back();
    }

    // var amount = controller.selectedItem!.price.toStringAsFixed(2);
    var amount = 0.0.obs;
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
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              collapsedHeight: MediaQuery.of(context).size.height * 0.1,
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
                height: MediaQuery.of(context).size.height * 0.55,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                            controller.updateFavourite(controller.selectedItem!,
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
                          child: Obx(() => Icon(
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
                          (index) => Obx(() {
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
                        Obx(() {
                          if(controller.selectedItem?.unitType != null && controller.selectedItem?.unitType?.isNotEmpty == true) {
                            amount.value = controller.selectedItem!.unitType![selectedUnitIndex.value].price;
                          } else {
                            amount.value = controller.selectedItem!.price;
                          }
                          return Text(
                            "Rs ${amount.toStringAsFixed(2)}",
                            style: AppTheme.moneyStyle,
                          );
                        }),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RoundedIconButton(
                                icon: Icons.remove,
                                onPress: () {
                                  if (itemNumber.value > 1) {
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
                                child: Obx(() => Text(
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
                        var item = controller.selectedItem!;
                        UnitType? unitType =
                            item.unitType?[selectedUnitIndex.value];
                        cartController.addToCart(
                            item, itemNumber.value, unitType);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(addedToCartSnackbar());
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
