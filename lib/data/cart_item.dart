import 'package:get/get.dart';

import 'item.dart';
import 'unit_type.dart';

class CartItem {
  String id;
  Item item;
  RxInt count;
  UnitType? type;
  RxDouble amount = 0.0.obs;

  CartItem(
      {required this.id,
      required this.item,
      required this.count,
      this.type,
      required this.amount});
}
