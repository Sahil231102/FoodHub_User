import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Order Model class for better type safety
class OrderItem {
  final String foodId;
  final int quantity;
  final String total;
  final String? foodName;
  final String? foodPrice;
  final String? foodImage;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.total,
    this.foodName,
    this.foodPrice,
    this.foodImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodId': foodId,
      'quantity': quantity,
      'total': total,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'images': foodImage,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      foodId: map['foodId'] ?? '',
      quantity: map['quantity'] ?? 0,
      total: map['total'] ?? '0',
      foodName: map['foodName'],
      foodPrice: map['foodPrice'],
      foodImage: map['image_urls'],
    );
  }
}

class OrderController extends GetxController {
  final _orderDetails = <String, dynamic>{}.obs;
  final _foodItems = <OrderItem>[].obs;
  final _userDetails = <String, dynamic>{}.obs;
  final _isLoading = true.obs;

  Map<String, dynamic> get orderDetails => _orderDetails;

  List<OrderItem> get foodItems => _foodItems;

  Map<String, dynamic> get userDetails => _userDetails;

  bool get isLoading => _isLoading.value;

  // Stream to get all orders
  Stream<List<Map<String, dynamic>>> getOrdersStream() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (userId.isEmpty) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Fetch specific order details
  Future<void> fetchOrderDetails(String orderId) async {
    try {
      _isLoading.value = true;

      final orderDoc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();
      if (!orderDoc.exists) {
        Get.snackbar("Error", "Order not found");
        return;
      }
      _orderDetails.value = Map<String, dynamic>.from(orderDoc.data() ?? {});

      final userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(_orderDetails['userId'])
          .get();
      if (userDoc.exists) {
        _userDetails.value = Map<String, dynamic>.from(userDoc.data() ?? {});
      }

      final List<OrderItem> items = [];
      for (var item in (_orderDetails['items'] as List? ?? [])) {
        final foodDoc = await FirebaseFirestore.instance
            .collection('FoodItems')
            .doc(item['foodId'])
            .get();

        if (foodDoc.exists && foodDoc.data() != null) {
          final foodData = foodDoc.data()!;
          items.add(
            OrderItem(
              foodId: item['foodId'],
              quantity: item['quantity'],
              total: item['total'],
              foodName: foodData['food_name'] ?? 'Unknown',
              foodPrice: foodData['food_price']?.toString() ?? '0',
              foodImage: foodData['image_urls'] != null &&
                      foodData['image_urls'] is List
                  ? (foodData['image_urls'] as List).isNotEmpty
                      ? (foodData['image_urls'] as List).first
                      : null
                  : foodData['image_urls']?.toString(),
            ),
          );
        }
      }

      _foodItems.value = items;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch order details");
    } finally {
      _isLoading.value = false;
    }
  }

  // New method to update order status
  Future<void> updateOrderStatus(String status) async {
    try {
      String orderId = _orderDetails['orderId'];
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      // Update order status locally
      _orderDetails['status'] = status;
      _orderDetails.refresh(); // Notify UI to update

      Get.snackbar("Success", "Order has been updated to $status");
    } catch (e) {
      Get.snackbar("Error", "Failed to update order status");
    }
  }

  double calculateTotalBill() {
    return _foodItems.fold(0.0, (sum, item) => sum + double.parse(item.total));
  }

  double getDeliveryCharge() => 50.0;

  double getTotalBillWithDelivery() =>
      calculateTotalBill() + getDeliveryCharge();

  String getOrderStatus() => _orderDetails['status'] ?? 'Pending';

  String getOrderDate() {
    final timestamp = _orderDetails['timestamp'] as Timestamp?;
    if (timestamp == null) return '';
    final dateTime = timestamp.toDate();
    return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
  }

  String getDeliveryAddress() => _orderDetails['address'] ?? '';
}
