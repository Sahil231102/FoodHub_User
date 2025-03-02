import 'package:get/get.dart';

class FoodDetailsController extends GetxController {
  int itemCount = 1;

  void increment() {
    itemCount++;
    update();
  }

  void decrement() {
    if (itemCount > 1) {
      itemCount--;
      update();
    }
  }
}
