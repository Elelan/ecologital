import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/cart.dart';
import '../../data/item.dart';
import '../../data/unit_type.dart';
import '../../service/api_service.dart';
import '../../utils/theme.dart';

class CartController extends GetxController {
  final api = Get.find<ApiService>();
  final box = GetStorage();

  final _isPlacingOrder = false.obs;

  bool get isPlacingOrder => _isPlacingOrder.value;

  var cartItems = List<Cart>.empty().obs;

  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialCart();
  }

  void loadInitialCart() async {
    final String? cartString = box.read('cart');
    if (cartString != null && cartString.isNullOrBlank == false) {
      final json = jsonDecode(cartString) as List;
      final items = json.map((item) => Cart.fromJson(item)).toList();
      if (cartItems.isEmpty) {
        cartItems.addAll(items);
        updateTotal();
      }
    }
    updateTotal();
  }

  void addToCartList(Item item, int quantity, UnitType? type) {
    var itemExists =
        cartItems.firstWhereOrNull((element) => element.id == item.id);
    Cart newCartItem;
    var amount = 0.0;
    if (type != null) {
      amount = quantity * type.price;
    } else {
      amount = quantity * item.price;
    }
    if (itemExists != null) {
      itemExists.count(quantity);
      itemExists.totalPrice(amount);
      var index =
          cartItems.indexWhere((element) => element.id == itemExists.id);
      cartItems[index] = itemExists;
    } else {
      var name = _buildCartItemName(item, type);
      newCartItem = Cart(
          id: item.id,
          name: name,
          count: RxInt(quantity),
          unitPrice: RxDouble(type != null ? type.price : item.price),
          totalPrice: RxDouble(amount),
          image: item.image);
      cartItems.add(newCartItem);
    }

    updateCartStorage(cartItems);
  }

  void updateCartStorage(List<Cart> cartItems) async {
    try {
      var dynamic = cartItems.map((item) => item.toJson()).toList();
      var encoded = jsonEncode(dynamic);
      box.write("cart", encoded);
    } catch (error) {
      error.printError();
    }
  }

  double calculateCartItemAmount(int quantity, double unitPrice) {
    var amount = quantity * unitPrice;
    return amount;
  }

  void decreaseCartItem(String id) {
    var index = cartItems.indexWhere((element) => element.id == id);
    var cartItem = cartItems[index];
    var newCount = cartItem.count > 1 ? cartItem.count - 1 : cartItem.count;
    var newAmount =
        calculateCartItemAmount(newCount.value, cartItem.unitPrice.value);
    updateCartItem(index, newCount.value, newAmount);
  }

  void increaseCartItem(String id) {
    var index = cartItems.indexWhere((element) => element.id == id);
    var cartItem = cartItems[index];
    var newCount = cartItem.count + 1;
    var newAmount =
        calculateCartItemAmount(newCount.value, cartItem.unitPrice.value);
    updateCartItem(index, newCount.value, newAmount);
  }

  void updateCartItem(int index, int count, double totalPrice) {
    cartItems[index].count(count);
    cartItems[index].totalPrice(totalPrice);
    updateTotal();
    updateCartStorage(cartItems);
  }

  void updateTotal() {
    if (cartItems.isNotEmpty) {
      var amount = cartItems
          .map((item) => item.totalPrice.value)
          .toList()
          .reduce((price1, price2) => price1 + price2);
      totalAmount(amount);
    } else {
      totalAmount(0);
    }
  }

  Cart? getCartItem(String id) =>
      cartItems.firstWhereOrNull((element) => element.id == id);

  String _buildCartItemName(Item item, UnitType? type) {
    if (type == null) {
      return item.name;
    }
    return "${item.name} (${type.value})";
  }

  int cartItemIndex(String id) =>
      cartItems.indexWhere((element) => element.id == id);

  void removeItemFromCart(String id) {
    var itemExists = cartItems.firstWhereOrNull((element) => element.id == id);
    if (itemExists != null) {
      cartItems.removeAt(cartItemIndex(id));
      updateTotal();
      updateCartStorage(cartItems);
    }
  }

  void clearCart() {
    cartItems.clear();
    updateCartStorage(cartItems);
    updateTotal();
  }

  void placeOrder() async {
    _isPlacingOrder(true);
    final orderRes = await api.placeOrder(cartItems.first.id);
    _isPlacingOrder(false);

    if (orderRes != null) {
      Get.defaultDialog(
          buttonColor: AppTheme.accentColor,
          confirmTextColor: AppTheme.textColorLight,
          title: "Success",
          middleText: orderRes.message,
          onConfirm: () {
            clearCart();
            Get.back();
          });
    } else {
      Get.defaultDialog(
          buttonColor: AppTheme.accentColor,
          confirmTextColor: AppTheme.textColorLight,
          title: "Error",
          middleText: "Couldn't place order",
          onConfirm: () {
            Get.back();
          });
    }
  }
}
