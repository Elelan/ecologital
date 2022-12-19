import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  String id;
  String name;
  @RxIntConverter()
  RxInt count;
  @RxDoubleConverter()
  RxDouble unitPrice;
  @RxDoubleConverter()
  RxDouble totalPrice;
  String image;

  Cart(
      {required this.id,
        required this.name,
      required this.count,
      required this.unitPrice,
      required this.totalPrice,
      required this.image});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

class RxIntConverter implements JsonConverter<RxInt, int> {
  const RxIntConverter();
  @override
  RxInt fromJson(int json) {
    return RxInt(json);
  }

  @override
  int toJson(RxInt object) {
    return object.value;
  }

}

class RxDoubleConverter implements JsonConverter<RxDouble, double> {
  const RxDoubleConverter();
  @override
  RxDouble fromJson(double json) {
    return RxDouble(json);
  }

  @override
  double toJson(RxDouble object) {
    return object.value;
  }

}