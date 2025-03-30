import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/order_controller.dart';
import 'package:food_hub_user/core/component/common_app_bar.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/const/text_style.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        text: "Order",
      ),
      body: StreamBuilder(
        stream: orderController.getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              "No orders placed yet !",
              style: AppTextStyle.w600(
                fontSize: 19,
                color: AppColors.black,
              ),
            ));
          }
          var orders = snapshot.data!;
          return ListView.separated(
            itemBuilder: (context, index) {
              final order = orders[index];

              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => OrderDetailsScreen(
                      orderId: order["orderId"],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 75,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: order["items"].length,
                          itemBuilder: (context, index) {
                            String foodId = order["items"][index]["foodId"];
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('FoodItems')
                                  .doc(foodId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const Icon(Icons.image_not_supported,
                                      size: 60);
                                }
                                var foodData = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                String? imageUrl =
                                    (foodData['image_urls'] as List?)?.first;

                                return imageUrl != null
                                    ? Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ).paddingSymmetric(
                                        horizontal: 5, vertical: 10)
                                    : const Icon(Icons.image_not_supported,
                                        size: 60);
                              },
                            );
                          },
                        ),
                      ),
                      Text(
                        "OrderId: ${order["orderId"]}",
                        style: AppTextStyle.w600(fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order['timestamp'] != null
                                ? DateFormat('dd MMMM yyyy hh:mm a').format(
                                    (order['timestamp'] as Timestamp).toDate(),
                                  )
                                : 'No Date Available',
                            style: AppTextStyle.w500(fontSize: 15),
                          ),
                          Text(
                            "₹${order["amount"]}",
                            style: AppTextStyle.w700(fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Order ${order["status"]}",
                            style: AppTextStyle.w700(fontSize: 15),
                          ),
                          10.sizeWidth,
                          if (order["status"] == "Pending")
                            Icon(
                              Icons.access_alarm,
                              size: 15,
                              color: Colors.orange.shade500,
                            )
                          else if (order["status"] == "Cancelled")
                            const Icon(
                              Icons.cancel,
                              size: 15,
                              color: Colors.red,
                            )
                          else if (order["status"] == "Delivered")
                            const Icon(
                              Icons.check_circle,
                              size: 15,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(
                    horizontal: 8,
                  ),
                ).paddingSymmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: orders.length,
          );
        },
      ),
    );
  }
}
