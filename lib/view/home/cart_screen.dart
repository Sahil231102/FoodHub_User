import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/add_to_cart_controller.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/services/navigation_services.dart';
import 'package:food_hub_user/view/home/address_screen.dart';
import 'package:get/get.dart';

import '../../core/component/common_app_bar.dart';
import '../../core/component/common_button.dart';
import '../../core/const/colors.dart';
import '../../core/const/text_style.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final AddToCartController cartController = Get.put(AddToCartController());

  @override
  void initState() {
    super.initState();
    cartController.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        text: "Cart",
      ),
      body: GetBuilder<AddToCartController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.cartItems.isEmpty) {
          return Center(
              child: Text(
            "Your cart is empty !",
            style: AppTextStyle.w700(
              fontSize: 19,
              color: AppColors.black,
            ),
          ));
        }

        int totalItems = controller.cartItems.fold(
            0,
            (sum, item) =>
                sum + (int.tryParse(item['quantity'].toString()) ?? 1));

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];

                  return Card(
                    color: AppColors.black,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 3, color: AppColors.white),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item["image"]),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                10.sizeHeight,
                                Text(item['name'],
                                    style: AppTextStyle.w700(
                                        fontSize: 15, color: AppColors.white)),
                                5.sizeHeight,
                                Text(
                                    "₹${double.tryParse(item['price'].toString())?.toInt() ?? 0}",
                                    style: AppTextStyle.w600(
                                        fontSize: 15, color: AppColors.white)),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        int currentQuantity = int.tryParse(
                                                item['quantity'].toString()) ??
                                            1;
                                        if (currentQuantity > 1) {
                                          controller.updateQuantity(
                                              item['foodId'],
                                              currentQuantity - 1);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.grey.shade700,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                        "${int.tryParse(item['quantity'].toString()) ?? 1}",
                                        style: AppTextStyle.w700(
                                            fontSize: 18,
                                            color: AppColors.white)),
                                    IconButton(
                                      onPressed: () {
                                        int currentQuantity = int.tryParse(
                                                item['quantity'].toString()) ??
                                            1;
                                        controller.updateQuantity(
                                            item['foodId'],
                                            currentQuantity + 1);
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.grey.shade700,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.removeFromCart(item['foodId']);
                            },
                            icon:
                                Icon(Icons.cancel, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Items",
                          style: AppTextStyle.w600(
                              fontSize: 16, color: AppColors.black)),
                      Text("$totalItems",
                          style: AppTextStyle.w600(
                              fontSize: 18, color: AppColors.black))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",
                          style: AppTextStyle.w700(
                              fontSize: 16, color: AppColors.black)),
                      Text("₹${controller.getTotalPrice()}",
                          style: AppTextStyle.w700(
                              fontSize: 16, color: AppColors.black)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Charge",
                        style: AppTextStyle.w500(
                            fontSize: 16, color: AppColors.black),
                      ),
                      Text("₹50",
                          style: AppTextStyle.w500(
                              fontSize: 16, color: AppColors.black))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price",
                          style: AppTextStyle.w700(
                              fontSize: 18, color: AppColors.black)),
                      Text("₹${controller.getTotalPrice() + 50}",
                          style: AppTextStyle.w700(
                              fontSize: 18, color: AppColors.black)),
                    ],
                  ),
                  20.sizeHeight,
                  CommonButton(
                    onPressed: () {
                      int totalAmount = controller.getTotalPrice() + 50;
                      NavigationServices.to(
                        () => AddressScreen(
                          payment: totalAmount.toString(),
                        ),
                      );
                    },
                    text: "Confirm",
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
