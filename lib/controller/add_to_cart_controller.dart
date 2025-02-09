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

      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).collection('cart').get();

      cartItems = cartSnapshot.docs.map((doc) {
        return {
          'productId': doc.id,
          'productName': doc['productName'],
          'price': doc['price'],
          'quantity': doc['quantity'],
          'image': doc['image'] ?? "",
        };
      }).toList();

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print("Error fetching cart items: $e");
    }
  }

  Future<void> addToCart({
    required String productId,
    required String productName,
    required String price,
    required String category,
    required String image,
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
          .doc(productId)
          .get();

      if (cartDoc.exists) {
        // If item already exists, update the quantity
        int currentQuantity = cartDoc['quantity'];
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('cart')
            .doc(productId)
            .update({
          'quantity': currentQuantity + quantity, // Increment quantity
        });
      } else {
        // If item doesn't exist, add it
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('cart')
            .doc(productId)
            .set({
          'productName': productName,
          'price': price,
          'category': category,
          'quantity': quantity,
          'image': image, // Save Base64 string
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
