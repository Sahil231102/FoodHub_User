import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetUserInfoController extends GetxController {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var userData = {}.obs; // Store user data
  var isLoading = false.obs; // Track loading state

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    if (userId == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    try {
      isLoading.value = true; // Start loading
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (userDoc.exists) {
        userData.assignAll(userDoc.data() as Map<String, dynamic>);
      } else {
        Get.snackbar("Error", "User not found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
