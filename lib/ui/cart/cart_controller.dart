import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/cart.dart';
import '../../data/cart_item.dart';
import '../../data/item.dart';
import '../../data/unit_type.dart';

class CartController extends GetxController {
  // var cartItems = List<CartItem>.empty().obs;
  var cartItems = List<Cart>.empty().obs;

  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialCart();
  }

  void loadInitialCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString('cart');
    if(cartString != null && cartString.isNullOrBlank == false) {
      final json = jsonDecode(cartString) as List;
      final items = json.map((item) => Cart.fromJson(item)).toList();
      if(cartItems.isEmpty) {
        cartItems.addAll(items);
        updateTotal();
      }
    }
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
      cartItems.add(itemExists);
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

  void updateCartStorage(List<Cart> cartItems) async{
    try {
      var dynamic = cartItems.map((item) => item.toJson()).toList();
      var encoded = jsonEncode(dynamic);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("cart", encoded);
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
    var newAmount = calculateCartItemAmount(newCount.value, cartItem.unitPrice.value);
    updateCartItem(index, newCount.value, newAmount);
  }

  void increaseCartItem(String id) {
    var index = cartItems.indexWhere((element) => element.id == id);
    var cartItem = cartItems[index];
    var newCount = cartItem.count + 1;
    var newAmount = calculateCartItemAmount(newCount.value, cartItem.unitPrice.value);
    updateCartItem(index, newCount.value, newAmount);
  }

  void updateCartItem(int index, int count, double totalPrice) {
    cartItems[index].count(count);
    cartItems[index].totalPrice(totalPrice);
    updateTotal();
    updateCartStorage(cartItems);
  }

  void updateTotal() {
    if(cartItems.isNotEmpty) {
      var amount = cartItems.map((item) => item.totalPrice.value)
          .toList()
          .reduce((price1, price2) => price1 + price2);
      totalAmount(amount);
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
}
