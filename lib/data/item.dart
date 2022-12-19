import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'unit_type.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  @JsonKey(name: "_id")
  String id;
  String name;
  String image;
  @JsonKey(name: "category_id")
  String categoryId;
  @JsonKey(name: "categoty_name")
  String categoryName;
  double price;
  @JsonKey(name: "unit_type")
  List<UnitType>? unitType;
  String description;

  @JsonKey(ignore: true)
  var isFavourite = false.obs;

  Item(
      {required this.id,
      required this.name,
      required this.image,
      required this.categoryId,
      required this.categoryName,
      required this.price,
      this.unitType,
      required this.description});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
