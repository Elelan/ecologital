import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import 'cart_controller.dart';
import 'widgets/cart_list_item.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart";

  CartPage({Key? key}) : super(key: key);

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    controller.loadInitialCart();
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bgColor,
        foregroundColor: AppTheme.textColorDark,
      ),
      body: Obx(() {
        if (controller.isPlacingOrder) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.textColorDark,
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.cartItems.isEmpty) {
                  return const Center(
                    child: Text("No Cart Items"),
                  );
                }
                return ListView.separated(
                  itemCount: controller.cartItems.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemBuilder: (context, index) =>
                      CartListItem(cartItem: controller.cartItems[index]),
                );
              }),
            ),
            SliverFillRemaining(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Obx(() => Visibility(
                          visible: controller.cartItems.isNotEmpty,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 32, bottom: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                          color: AppTheme.textColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(() => Text(
                                          controller.totalAmount
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                              color: AppTheme.textColorDark,
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 32, bottom: 16),
                                child: MaterialButton(
                                  onPressed: () {
                                    controller.placeOrder();
                                  },
                                  height: 50,
                                  elevation: 0,
                                  color: AppTheme.accentColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      "Place order",
                                      style: TextStyle(
                                          color: AppTheme.textColorLight),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
