import '../cart/cart_controller.dart';
import 'home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    
    Get.put(HomeController());
    Get.put(CartController());
  }
  
}