// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as String,
      name: json['name'] as String,
      count: const RxIntConverter().fromJson(json['count'] as int),
      unitPrice:
          const RxDoubleConverter().fromJson(json['unitPrice'] as double),
      totalPrice:
          const RxDoubleConverter().fromJson(json['totalPrice'] as double),
      image: json['image'] as String,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': const RxIntConverter().toJson(instance.count),
      'unitPrice': const RxDoubleConverter().toJson(instance.unitPrice),
      'totalPrice': const RxDoubleConverter().toJson(instance.totalPrice),
      'image': instance.image,
    };
