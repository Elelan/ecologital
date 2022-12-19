import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: "_id")
  String id;
  String name;
  String image;

  @JsonKey(ignore: true)
  var itemList = List<Item>.empty().obs;

  @JsonKey(ignore: true)
  var page = 1.obs;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
