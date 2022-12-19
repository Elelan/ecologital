import '../home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';
import '../../cart/cart_page.dart';
import 'custom_search_delegate.dart';

class AppBarRow extends StatelessWidget {
  AppBarRow({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Get.toNamed(CartPage.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppTheme.textColor,
              )),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppTheme.bgColor,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                focusNode: focusNode,
                onTap: () async {
                  final result = await showSearch(
                      context: context, delegate: CustomSearchDelegate());
                  if (result != null) {
                    controller.navigateToDetail(result.id);
                  }
                  focusNode.unfocus();
                  focusNode.removeListener(() { });
                },
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.textColor,
                    ),
                    label: Text("Search")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
