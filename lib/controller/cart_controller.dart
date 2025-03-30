import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = false;

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? "";
  }

  Future<String> getCurrentUserPhoneNumber() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return "Not Available";

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user') // Ensure this is your users collection name
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.get('mobile_number') ??
            "Not Available"; // Field name in Firestore
      } else {
        return "Not Available";
      }
    } catch (e) {
      print("Error fetching user phone number: $e");
      return "Not Available";
    }
  }

  Future<void> fetchCartItems() async {
    try {
      isLoading = true;
      update();

      String userId = getCurrentUserId();

      if (userId.isEmpty) throw Exception('User not logged in');

      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: userId) // **Filter for current user**
          .get();

      cartItems = await Future.wait(cartSnapshot.docs.map((doc) async {
        var cartData = doc.data() as Map<String, dynamic>;
        var foodDoc = await FirebaseFirestore.instance
            .collection('FoodItems')
            .doc(cartData['foodId'])
            .get();
        var foodData = foodDoc.data() as Map<String, dynamic>;

        return {
          'cartId': doc.id,
          'userId': userId,
          'foodId': cartData['foodId'],
          'quantity': cartData['quantity'],
          'name': foodData['food_name'] ?? 'Unknown',
          'price': foodData['food_price'] ?? '0',
          'image': (foodData['image_urls'] as List<dynamic>?)?.first ?? '',
        };
      }).toList());
    } catch (e) {
      print("Error fetching cart items: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addToCart(
      {required String foodId, required int quantity}) async {
    try {
      isLoading = true;
      update();

      String userId = getCurrentUserId();

      if (userId.isEmpty) throw Exception('User not logged in');

      QuerySnapshot existingCartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .where('foodId', isEqualTo: foodId)
          .get();

      if (existingCartSnapshot.docs.isNotEmpty) {
        // Item already in cart, update quantity
        DocumentReference cartRef = existingCartSnapshot.docs.first.reference;
        int currentQuantity = existingCartSnapshot.docs.first['quantity'];
        await cartRef.update({'quantity': currentQuantity + quantity});
      } else {
        // Add new item to cart
        await FirebaseFirestore.instance.collection('cart').add({
          'userId': userId, // **Store user ID in cart item**
          'foodId': foodId,
          'quantity': quantity,
        });
      }

      await fetchCartItems();
    } catch (e) {
      print("Error adding item to cart: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateQuantity(String cartId, int newQuantity) async {
    if (newQuantity < 1) return;

    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(cartId)
          .update({'quantity': newQuantity});

      await fetchCartItems();
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  Future<void> removeFromCart(String cartId) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(cartId).delete();

      await fetchCartItems();
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
