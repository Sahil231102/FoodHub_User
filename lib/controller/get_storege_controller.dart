import 'package:food_hub_user/view/auth/welcome_screen.dart';
import 'package:food_hub_user/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageController extends GetxController {
  void checkUserData() async {
    var box = GetStorage();
    await Future.delayed(Duration(seconds: 2)); // Simulate splash screen delay
    bool isLoggedIn = box.read('isLoggedIn') ?? false; // Default to false
    if (isLoggedIn) {
      Get.to(() => HomeScreen());
    } else {
      Get.to(() => WelcomeScreen());
    }
  }
}
