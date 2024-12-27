import 'package:get/get.dart';

class LocationController extends GetxController {
  String country = '';
  String countryPhone = '';
  String state = '';
  String city = '';

  void updateCountry(String? value) {
    country = value ?? '';

    countryPhone = country.toString();
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
}
