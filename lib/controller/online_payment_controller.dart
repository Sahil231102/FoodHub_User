import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/core/component/bottom_navigation_bar_screen.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OnlinePaymentController extends GetxController {
  late Razorpay _razorpay;
  String userAddress = "";
  var paymentAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void setUserAddress({
    required String flatNumber,
    required String homeAddress,
    required String landmark,
    required String city,
    required String pinCode,
  }) {
    userAddress = "$flatNumber,  $homeAddress , $landmark , $city , $pinCode.";
  }

  Future<void> openCheckout({required String payment, String? mobileNumber}) async {
    paymentAmount.value = double.parse(payment);
    var options = {
      'key': 'rzp_test_oR6NQlpwHLnUE0',
      'amount': int.parse(payment) * 100,
      'name': 'Food Hub',
      'description': 'Order Payment',
      'prefill': {
        'contact': mobileNumber,
        'email': 'customer@example.com',
      },
      'theme': {
        'color': '#F37254',
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> placeCashOrder(String payment) async {
    paymentAmount.value = double.parse(payment);
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (userId.isEmpty || userAddress.isEmpty) {
      Get.snackbar("Error", "Please enter your address before placing an order.");
      return;
    }

    QuerySnapshot cartSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).collection('cart').get();

    if (cartSnapshot.docs.isEmpty) {
      Get.snackbar("Cart Empty", "Your cart is empty, cannot place an order.");
      return;
    }

    String orderId = "ORD${DateTime.now().millisecondsSinceEpoch}";
    List<Map<String, dynamic>> orderItems = [];

    for (var doc in cartSnapshot.docs) {
      String foodId = doc.id;
      int quantity = (doc['quantity'] as num).toInt();

      DocumentSnapshot foodDoc =
          await FirebaseFirestore.instance.collection('FoodItems').doc(foodId).get();

      if (!foodDoc.exists) continue;

      Map<String, dynamic>? foodData = foodDoc.data() as Map<String, dynamic>?;
      double price = double.tryParse(foodData?['food_price'].toString() ?? '0') ?? 0.0;

      orderItems.add({
        'foodId': foodId,
        'quantity': quantity,
        'total': (price * quantity).toString(),
      });
    }

    if (orderItems.isEmpty) {
      Get.snackbar("Order Failed", "No valid items found in your cart.");
      return;
    }

    await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
      'orderId': orderId, // Store Order ID
      'userId': userId,
      'items': orderItems,
      'address': userAddress,
      "amount": paymentAmount.value,
      'paymentType': "COD",
      'paymentId': "",
      'status': "Pending",
      'timestamp': DateTime.now()
    });

    for (var doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }

    Get.snackbar("Order Placed", "Your cash order has been placed successfully!");
    Get.offAll(() => const BottomNavigationBarScreen());
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      if (userId.isEmpty || userAddress.isEmpty) return;

      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).collection('cart').get();

      if (cartSnapshot.docs.isEmpty) {
        Get.snackbar("Cart Empty", "Your cart is empty, cannot place an order.");
        return;
      }

      String orderId = "ORD${DateTime.now().millisecondsSinceEpoch}";
      List<Map<String, dynamic>> orderItems = [];

      for (var doc in cartSnapshot.docs) {
        String foodId = doc.id;
        int quantity = (doc['quantity'] as num).toInt();

        DocumentSnapshot foodDoc =
            await FirebaseFirestore.instance.collection('FoodItems').doc(foodId).get();

        if (!foodDoc.exists) continue;

        Map<String, dynamic>? foodData = foodDoc.data() as Map<String, dynamic>?;
        double price = double.tryParse(foodData?['food_price'].toString() ?? '0') ?? 0.0;

        orderItems.add({
          'foodId': foodId,
          'quantity': quantity,
          'total': (price * quantity).toString(),
        });
      }

      if (orderItems.isEmpty) {
        Get.snackbar("Order Failed", "No valid items found in your cart.");
        return;
      }

      await FirebaseFirestore.instance.collection('orders').doc(orderId).set(
        {
          'orderId': orderId,
          'userId': userId,
          'items': orderItems,
          'address': userAddress,
          "amount": paymentAmount.value,
          'paymentType': "Online",
          'paymentId': response.paymentId,
          'status': "Pending",
          'timestamp': DateTime.now()
        },
      );

      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      Get.snackbar(
          "Payment Success", "Your payment was successful, and the order has been placed!");
      Get.offAll(() => const BottomNavigationBarScreen());
    } catch (e) {
      debugPrint("Error handling payment success: $e");
      Get.snackbar("Error", "Something went wrong while placing your order.");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet Selected", "${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
