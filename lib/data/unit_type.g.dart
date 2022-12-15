// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitType _$UnitTypeFromJson(Map<String, dynamic> json) => UnitType(
      name: json['name'] as String,
      value: json['value'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$UnitTypeToJson(UnitType instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'price': instance.price,
    };
