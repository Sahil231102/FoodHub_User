import 'package:get/get.dart';

class FoodDetailsController extends GetxController {
  int itemCount = 1; // Normal variable (not observable)

  void increment() {
    itemCount++;
    update(); // Notify listeners to rebuild UI
  }

  void decrement() {
    if (itemCount > 1) {
      itemCount--;
      update(); // Notify listeners to rebuild UI
    }
  }
}
