import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = false;

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? "";
  }

  Future<void> fetchCartItems() async {
    try {
      isLoading = true;
      update();

      String userId = getCurrentUserId();
      if (userId.isEmpty) throw Exception('User not logged in');

      // Fetch cart items
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).collection('cart').get();

      List<String> foodIds = cartSnapshot.docs.map((doc) => doc.id).toList();
      List<int> quantities =
          cartSnapshot.docs.map((doc) => (doc['quantity'] as num).toInt()).toList();

      if (foodIds.isEmpty) {
        cartItems = [];
        isLoading = false;
        update();
        return;
      }

      List<DocumentSnapshot> foodDocs = await Future.wait(
        foodIds.map((id) => FirebaseFirestore.instance.collection('foodItems').doc(id).get()),
      );

      cartItems = List.generate(foodDocs.length, (index) {
        var foodData = foodDocs[index].data() as Map<String, dynamic>?;

        return {
          'foodId': foodIds[index],
          'quantity': quantities[index],
          'name': foodData?['food_name'] ?? 'Unknown',
          'price': foodData?['food_price'] ?? '0',
          'image': (foodData?['images'] as List<dynamic>?)?.first ?? '',
        };
      });

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print("Error fetching cart items: $e");
    }
  }

  Future<void> addToCart({
    required String foodId,
    required double quantity,
  }) async {
    try {
      isLoading = true; // Set loading to true
      update();
      String userId = getCurrentUserId();
      if (userId.isEmpty) throw Exception('User not logged in');

      // Check if product already exists in cart
      DocumentSnapshot cartDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('cart')
          .doc(foodId)
          .get();

      if (cartDoc.exists) {
        int currentQuantity = cartDoc['quantity'];
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('cart')
            .doc(foodId)
            .update({
          'foodId': foodId,
          'quantity': currentQuantity + quantity,
        });
      } else {
        // If item doesn't exist, add it
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('cart')
            .doc(foodId)
            .set({
          'foodId': foodId,
          'quantity': quantity,
        });
      }
      fetchCartItems(); // Refresh cart data after adding
    } catch (e) {
      print("Error adding item to cart: $e");
    } finally {
      isLoading = false; // Set loading to true
      update();
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) return; // Prevent negative quantity

    try {
      String userId = getCurrentUserId();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .update({'quantity': newQuantity});

      fetchCartItems(); // Refresh cart data
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      String userId = getCurrentUserId();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .delete();

      fetchCartItems(); // Refresh cart data
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  int getTotalPrice() {
    return cartItems.fold<int>(0, (sum, item) {
      num price = num.tryParse(item['price'].toString()) ?? 0;
      num quantity = num.tryParse(item['quantity'].toString()) ?? 0;

      return sum + (price * quantity).toInt();
    });
  }
}
