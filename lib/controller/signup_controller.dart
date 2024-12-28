import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/auth/user_info_screen.dart';
import 'package:food_hub_user/view/widget/app_snackbar.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool ioLoading = false;

  String userId = "";

  Future<void> signUpData(
      {required String email, required String password, required String name}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        ioLoading = true;
        update();

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String userid = userCredential.user?.uid ?? '';

        await FirebaseServices.useFirestore.doc(userid).set({
          "uid": userid,
          "password": password,
          "email": email,
          "name": name,
          "last_login_time": DateTime.now(),
        });

        if (userid != null) {
          Get.to(() => UserInfoScreen(
                uid: userid,
              ));
          AppSnackbar.showError(
              message: "Welcome! You have successfully signed up.", title: "Sign Up Successful");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          AppSnackbar.showError(
            message: "The email address is already in use by another account.",
            title: "Sign Up Filed",
          );
        } else if (e.code == "weak-password") {
          AppSnackbar.showError(
            message: "The password is too weak.",
            title: "Sign Up Filed",
          );
        } else if (e.code == "invalid-email") {
          AppSnackbar.showError(
            message: "The email address is not valid.",
            title: "Sign Up Filed",
          );
        }
      }
    }
  }
}
