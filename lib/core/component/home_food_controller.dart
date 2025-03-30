import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeFoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var foodItems = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRandomFoodItems();
  }

  Future<void> fetchRandomFoodItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('FoodItems').get();
      var allItems = snapshot.docs;
      allItems.shuffle(); // Randomize items
      foodItems.value = allItems.take(5).toList();
    } catch (e) {
      print('Error fetching food items: $e');
    }
  }
}
