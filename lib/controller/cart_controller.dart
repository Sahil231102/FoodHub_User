import 'package:get/get.dart';

class CartController extends GetxController {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String id, int quantity) {
    int index = cartItems.indexWhere((item) => item['foodId'] == id);
    if (index != -1) {
      cartItems[index]['quantity'] += quantity;
    } else {
      cartItems.add({"foodId": id, "quantity": quantity});
    }
    update();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    update();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      cartItems[index]['quantity'] = quantity;
    } else {
      removeFromCart(index);
    }
    update();
  }

  int getTotalPrice() {
    return cartItems.fold<int>(0, (sum, item) {
      return sum + ((item['price'] as int) * (item['quantity'] as int));
    });
  }
}
