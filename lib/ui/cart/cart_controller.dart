import '../../data/cart_item.dart';
import '../../data/item.dart';
import '../../data/unit_type.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  var cartItems = List<CartItem>.empty().obs;

  void addToCart(Item item, int quantity, UnitType? type) {
    var itemExists = cartItems.firstWhereOrNull((element) => element.id == item.id);
    CartItem newCartItem;
    var amount = 0.0;
    if (type != null) {
      amount = quantity * type.price;
    } else {
      amount = quantity * item.price;
    }
    if(itemExists!= null) {
      itemExists.count(quantity);
      itemExists.amount(amount);
      cartItems.add(itemExists);
    } else {
      newCartItem = CartItem(id: item.id, item: item, count: RxInt(quantity), amount: RxDouble(amount));
      cartItems.add(newCartItem);
    }
  }

  double calculateCartItemAmount(Item item, int quantity, UnitType? type) {
    var amount = 0.0;
    if (type != null) {
      amount = quantity * type.price;
    } else {
      amount = quantity * item.price;
    }
    return amount;
  }

  void decreaseCartItem(String id) {
    var index = cartItems.indexWhere((element) => element.id == id);
    var newCount = cartItems[index].count.value - 1;
    var newAmount = calculateCartItemAmount(cartItems[index].item, newCount, cartItems[index].type);
    updateCartItem(index, newCount, newAmount);
  }

  void increaseCartItem(String id) {
    var index = cartItems.indexWhere((element) => element.id == id);
    var newCount = cartItems[index].count.value + 1;
    var newAmount = calculateCartItemAmount(cartItems[index].item, newCount, cartItems[index].type);
    updateCartItem(index, newCount, newAmount);
  }

  void updateCartItem(int index, int count, double amount) {
    cartItems[index].count(count);
    cartItems[index].amount(amount);
  }
}