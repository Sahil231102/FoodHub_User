import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/controller/food_details_controller.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String document_id;

  FoodDetailsScreen({super.key, required this.document_id});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  late Future<DocumentSnapshot> foodDetailsFuture;

  final FoodDetailsController controller = Get.put(FoodDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    foodDetailsFuture = _fireStore.collection('FoodItems').doc(widget.document_id).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        text: "Food Details",
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: foodDetailsFuture,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching food details"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                "Food details not found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }

          final foodData = snapshot.data!.data() as Map<String, dynamic>;
          final List<dynamic> images = foodData['images'] ?? [];
          final String foodName = foodData['food_name'] ?? "Unknown";
          final String foodPrice = foodData['food_price'] ?? "Unknown";
          final String foodCategory = foodData['food_category'] ?? "Unknown";
          final String foodDescription = foodData['food_description'] ?? "No description provided";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 350,
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final String base64Image = images[index];
                    final decodedImage = base64Decode(base64Image);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          image: DecorationImage(
                            image: MemoryImage(
                              decodedImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.sizeHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${foodCategory}",
                              style: AppTextStyle.w700(
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "${foodName}",
                              style: AppTextStyle.w700(fontSize: 13, color: AppColors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            2.sizeWidth,
                            Text(
                              "15-20 min",
                              style: AppTextStyle.w700(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.sizeHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹${foodPrice}",
                          style: AppTextStyle.w700(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  controller.decrement();
                                },
                                icon: const Icon(Icons.remove, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: GetBuilder<FoodDetailsController>(
                                builder: (controller) {
                                  return Text(
                                    controller.itemCount.toString(),
                                    style: AppTextStyle.w700(fontSize: 20),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  controller.increment();
                                },
                                icon: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    20.sizeHeight,
                    Text(
                      "Description",
                      style: AppTextStyle.w700(
                        fontSize: 20,
                      ),
                    ),
                    20.sizeHeight,
                    Text(
                      "${foodDescription}",
                      style: AppTextStyle.w400(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    20.sizeHeight,
                    20.sizeHeight,
                    AuthCommanButton(text: "Add To Cart"),
                    20.sizeHeight,
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
