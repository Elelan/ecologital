import 'package:ecologital/ui/cart/cart_controller.dart';
import 'package:ecologital/ui/cart/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart";

  CartPage({Key? key}) : super(key: key);

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bgColor,
        foregroundColor: AppTheme.textColor,
      ),
      body: Obx(() {
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
      }
      ),
    );
  }
}
