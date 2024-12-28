import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoController extends GetxController {
  bool isUpdate = false;
  final ImagePicker picker = ImagePicker();
  final List<XFile> selectedImages = [];

  Future<void> ImagePickerSelect() async {}

  var selectedGender = 'Male'.obs; // Observable variable

  // Function to update the selected gender
  void updateGender(String gender) {
    selectedGender.value = gender;
    update(); // This manually triggers the update for the widget
  }

  Future<void> userInformationData({
    String? uid,
    String? city,
    String? country,
    String? state,
    String? mobileNumber,
    String? gender,
  }) async {
    try {
      if (city != null ||
          country != null ||
          state != null ||
          mobileNumber != null ||
          gender != null) {
        await FirebaseServices.useFirestore.doc(uid).update(
          {
            "city": city,
            "country": country,
            "state": state,
            "mobile_number": mobileNumber,
            "gender": gender
          },
        );
        isUpdate = true;
        update();
        Get.to(() => LoginScreen());
      }
    } catch (e) {
      print("==========>$e");
    } finally {
      isUpdate = false;
      update();
    }
  }
}
