import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      final querySnapshot =
          await _firestore.collection('food_categories').get();
      categories.value = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
}
