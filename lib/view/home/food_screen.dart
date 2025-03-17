import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/core/const/text_style.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/services/navigation_services.dart';
import 'package:food_hub_user/view/home/food_details_screen.dart';
import 'package:get/get.dart';

import '../../core/component/common_app_bar.dart';
import '../../core/const/colors.dart';

class FoodScreen extends StatefulWidget {
  final String? foodCategory;

  const FoodScreen({super.key, this.foodCategory});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query.trim().toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for food...',
                        hintStyle: AppTextStyle.w400(
                            fontSize: 15, color: AppColors.black),
                        prefixIcon:
                            const Icon(Icons.search, color: AppColors.black),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color:
                                Colors.black, // Border color when not focused
                            width: 2, // Border width
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black, // Border color when focused
                            width: 2.5, // Slightly thicker border
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices.foodFirestore.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5, // Makes it more visible
                          ),
                        );
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No Food Items Found",
                            style: AppTextStyle.w600(fontSize: 18),
                          ),
                        ).paddingSymmetric(vertical: 20);
                      }

                      final List<DocumentSnapshot> foodItems =
                          snapshot.data!.docs;

                      final List<DocumentSnapshot> filteredFoodItems =
                          foodItems.where((food) {
                        String category =
                            food['food_category']?.toString().toLowerCase() ??
                                '';
                        String name =
                            food['food_name']?.toString().toLowerCase() ?? '';

                        bool matchesCategory = widget.foodCategory == null ||
                            category == widget.foodCategory!.toLowerCase();
                        bool matchesSearch =
                            searchQuery.isEmpty || name.contains(searchQuery);

                        return matchesCategory && matchesSearch;
                      }).toList();

                      return filteredFoodItems.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  Center(
                                    child: Text("No Food Items Found",
                                        style: AppTextStyle.w700(fontSize: 20)),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemCount: filteredFoodItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final food = filteredFoodItems[index];
                                final String foodName =
                                    food['food_name'] ?? 'No Name';
                                final String foodCategory =
                                    food['food_category'] ?? 'No Category';
                                final String foodPrice =
                                    food['food_price'] ?? '0';
                                final List<dynamic> base64Images =
                                    food['image_urls'] ?? [];
                                final String imageUrl = base64Images.isNotEmpty
                                    ? base64Images[0]
                                    : '';

                                return GestureDetector(
                                  onTap: () => NavigationServices.to(
                                    () => FoodDetailsScreen(
                                        documentId: food['food_id']),
                                  ),
                                  child: Card(
                                    color: Colors.black87,
                                    elevation: 1,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.white,
                                                width: 3,
                                              ),
                                              image: imageUrl.isNotEmpty
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrl),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  foodName,
                                                  style: AppTextStyle.w700(
                                                    fontSize: 15,
                                                    color: AppColors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                5.sizeHeight,
                                                Text(
                                                  "Price: $foodPrice",
                                                  style: AppTextStyle.w700(
                                                    fontSize: 15,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                                5.sizeHeight,
                                                Text(
                                                  foodCategory,
                                                  style: AppTextStyle.w700(
                                                    fontSize: 15,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                thickness: 3,
                              ),
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
