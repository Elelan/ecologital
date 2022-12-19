import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecologital/data/cart_item.dart';
import 'package:ecologital/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/rounded_icon_button.dart';
import '../cart_controller.dart';

class CartListItem extends StatelessWidget {
  CartListItem({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  cartItem.item.image),
                              fit: BoxFit.cover)),
                    )),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 14,
                    child: Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "${cartItem.item.name}${cartItem.type != null ? '(${cartItem.type?.value})' : ''}",
                            style: const TextStyle(
                                color: AppTheme.textColor, fontSize: 16),
                          ),

                          Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RoundedIconButton(
                                    icon: Icons.remove,
                                    onPress: () {
                                      if (cartItem.count.value > 1) {
                                        //cartItem.count(cartItem.count.value-1);
                                        controller.decreaseCartItem(cartItem.id);
                                      }
                                    },
                                    iconSize: 24,
                                    fillColor: Colors.grey.shade300,
                                    iconColor: Colors.black,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Obx(() =>
                                        Text(
                                          "${cartItem.count.value}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  RoundedIconButton(
                                    icon: Icons.add,
                                    onPress: () {
                                      //cartItem.count(cartItem.count.value + 1);
                                      controller.increaseCartItem(cartItem.id);
                                    },
                                    iconSize: 24,
                                    fillColor: AppTheme.accentColor,
                                    iconColor: Colors.white,
                                  )
                                ],
                              ),

                              Text(
                                "Rs ${cartItem.amount.toStringAsFixed(2)}",
                                style: const TextStyle(color: AppTheme.textColor, fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                        ],
                      ),
                    )),
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  splashRadius: 1,
                )
            )
          ],
        ),
      ),
    );
  }
}
