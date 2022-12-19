import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

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

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        item = json['item'],
        count = json['count'],
        type = json['type'],
        amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item,
      'count': count,
      'type': type,
      'amount': amount,
    };
  }
}

class RxIntConverter implements JsonConverter<RxInt, int> {
  @override
  RxInt fromJson(int count) {
    return RxInt(count);
  }

  @override
  int toJson(RxInt count) {
    return count.value;
  }
}

class RxDoubleConverter implements JsonConverter<RxDouble, double> {
  @override
  RxDouble fromJson(double amount) {
    return RxDouble(amount);
  }

  @override
  double toJson(RxDouble count) {
    return count.value;
  }
}
