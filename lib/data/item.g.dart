// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      categoryId: json['category_id'] as String,
      categoryName: json['categoty_name'] as String,
      price: json['price'] as int,
      unitType: (json['unit_type'] as List<dynamic>?)
          ?.map((e) => UnitType.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'category_id': instance.categoryId,
      'categoty_name': instance.categoryName,
      'price': instance.price,
      'unit_type': instance.unitType,
      'description': instance.description,
    };
