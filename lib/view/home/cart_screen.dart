import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';

import '../widget/auth_comman_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> quantities = [1, 2, 3, 4];
  List<String> foodNames = [
    "Gujarati Thali",
    "Punjabi Thali",
    "South Indian Thali",
    "South Indian Thali",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        text: "Checkout",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(
                children: List.generate(quantities.length, (index) {
                  return Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage(AppImages.Gujarati_thali),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      foodNames[index],
                                      style: AppTextStyle.w700(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "₹120",
                                      style: AppTextStyle.w700(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (quantities[index] > 1) {
                                                quantities[index]--;
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          "${quantities[index]}",
                                          style: AppTextStyle.w700(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              quantities[index]++;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              quantities.removeAt(index);
                              foodNames.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        foodNames.length,
                        (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                foodNames[index],
                                style: AppTextStyle.w700(
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "₹${quantities[index] * 120}",
                                style: AppTextStyle.w700(
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(
                        thickness: 2,
                        color: AppColors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: AppTextStyle.w700(
                                color: AppColors.black,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "₹${quantities.fold<int>(0, (sum, qty) => sum + qty * 120)}",
                              style: AppTextStyle.w700(
                                color: AppColors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AuthCommanButton(
                        text: "Proceed to Checkout",
                        onTap: () {
                          // Handle checkout logic
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Price Summary Section
            ],
          ),
        ),
      ),
    );
  }
}
