import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:food_hub_user/view/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoController extends GetxController {
  bool isUpdate = false;
  final ImagePicker picker = ImagePicker();
  final List<XFile> selectedImages = [];

  String countryName = '';
  String countryCode = '';
  String countryPhone = '';

  String state = '';
  String city = '';

  var selectedGender = '';

  //  selected gender
  void updateGender(String gender) {
    selectedGender = gender;
    update(); // This manually triggers the update for the widget
  }

  //City , country, state Picker

  void updateCountry(String? value) {
    countryName = value ?? '';

    countryPhone = countryName.toString();
    update(); // Notify listeners
  }

  void updateState(String? value) {
    state = value ?? '';
    update(); // Notify listeners
  }

  void updateCity(String? value) {
    city = value ?? '';
    update(); // Notify listeners
  }

  //UserInformation

  Future<void> userInformationData({
    String? uid,
    String? city,
    String? countryName,
    String? countryCode,
    String? state,
    String? mobileNumber,
    String? gender,
  }) async {
    try {
      if (uid!.isEmpty ||
          city != null ||
          countryName != null ||
          state != null ||
          mobileNumber != null ||
          gender != null) {
        await FirebaseServices.useFirestore.doc(uid).update(
          {
            "mobile_number": mobileNumber,
            "gender": gender,
            "country_name": countryName,
            "country_code": countryCode,
            "state": state,
            "city": city,
          },
        );
        AppSnackbar.showSuccess(
            message: "Your account has been created successfully.", title: "Signup Successfully");
        isUpdate = true;
        update();
        Get.to(() => LoginScreen());
      }
    } catch (e) {
      print("==========>$e");
    }
  }
}
