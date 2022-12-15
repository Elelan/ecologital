import 'package:json_annotation/json_annotation.dart';

part 'unit_type.g.dart';

@JsonSerializable()
class UnitType {
  String name;
  String value;
  double price;

  UnitType({required this.name, required this.value, required this.price});

  factory UnitType.fromJson(Map<String, dynamic> json) =>
      _$UnitTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UnitTypeToJson(this);
}