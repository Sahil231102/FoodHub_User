import 'package:get/get.dart';

class CartController extends GetxController {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String name, int price, int quantity) {
    int index = cartItems.indexWhere((item) => item['name'] == name);
    if (index != -1) {
      cartItems[index]['quantity'] += quantity;
    } else {
      cartItems.add({"name": name, "price": price, "quantity": quantity});
    }
    update(); // Notify UI to update
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
