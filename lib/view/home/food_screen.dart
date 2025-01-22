import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/home/food_details_screen.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  // Sample food items
  // final List<Map<String, String>> foodItems = [
  //   {'name': 'Chicken Burger', 'price': '₹120', 'image': AppImages.page_2},
  //   {'name': 'Veg Pizza', 'price': '₹150', 'image': AppImages.page_4}, // Add your food data here
  //   {'name': 'Cheese Sandwich', 'price': '₹80', 'image': AppImages.burger},

  // Add more food items as required
  // ];

  // For storing search query
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter the list based on search query

    return Scaffold(
      appBar: const CommonAppBar(
        text: "Food",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for food...',
                        hintStyle: AppTextStyle.w400(fontSize: 15, color: AppColors.white),
                        prefixIcon: const Icon(Icons.search, color: AppColors.white),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // Food List
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices.foodFirestore.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 50),
                              SizedBox(height: 20),
                              Text(
                                "Error loading data. Please try again later.",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage(""),
                                height: 420,
                                width: 400,
                              ),
                              Text("No Food Items. Add Food Item.",
                                  style: AppTextStyle.w700(fontSize: 20)),
                            ],
                          ),
                        );
                      }

                      final List<DocumentSnapshot> foodItems = snapshot.data!.docs;
                      final filteredFoodItems = foodItems
                          .where((food) => (food['food_category']?.toString().toLowerCase() ?? '')
                              .contains(searchQuery.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        itemCount: filteredFoodItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final food = filteredFoodItems[index];
                          final String foodName = food['food_name'] ?? 'No Name';
                          final String foodCategory = food['food_category'] ?? 'No Category';
                          final String foodPrice = food['food_price'] ?? '0';
                          final List<dynamic> base64Images = food['images'] ?? [];
                          Uint8List? firstImageBytes;

                          if (base64Images.isNotEmpty) {
                            try {
                              firstImageBytes = base64Decode(base64Images[0]) as Uint8List?;
                            } catch (e) {
                              Get.snackbar("Error", e.toString());
                            }
                          }
                          return Stack(
                            children: [
                              Card(
                                color: Colors.black87,
                                elevation: 1,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                            image: MemoryImage(firstImageBytes!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              foodName,
                                              style: AppTextStyle.w700(
                                                fontSize: 18,
                                                color: AppColors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            5.sizeHeight,
                                            Text(
                                              "Price: ${foodPrice}",
                                              style: AppTextStyle.w700(
                                                fontSize: 18,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            5.sizeHeight,
                                            Text(
                                              foodCategory,
                                              style: AppTextStyle.w700(
                                                fontSize: 18,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 12,
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(() => FoodDetailsScreen(
                                            document_id: food['food_id'],
                                          ));
                                    },
                                    child: Text(
                                      "View",
                                      style: AppTextStyle.w700(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
