import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/add_to_cart_controller.dart';
import 'package:food_hub_user/controller/food_details_controller.dart';
import 'package:food_hub_user/core/component/common_app_bar.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/const/text_style.dart';
import 'package:food_hub_user/core/utils/app_snackbar.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/services/navigation_services.dart';
import 'package:get/get.dart';

import '../../core/component/bottom_navigation_bar_screen.dart';
import '../../core/component/common_button.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String documentId;

  const FoodDetailsScreen({super.key, required this.documentId});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  late final Future<DocumentSnapshot> foodDetailsFuture;

  final FoodDetailsController foodController = Get.put(FoodDetailsController());
  final AddToCartController cartController = Get.put(AddToCartController());

  @override
  void initState() {
    super.initState();
    foodDetailsFuture =
        _fireStore.collection('FoodItems').doc(widget.documentId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        text: "Food Details",
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: foodDetailsFuture,
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
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
            final List<dynamic> images = foodData['image_urls'] ?? [];
            final String foodName = foodData['food_name'] ?? "Unknown";
            final String foodPrice = foodData['food_price'] ?? "Unknown";
            final String foodId = foodData['food_id'] ?? "Unknown";
            final String foodCategory = foodData['food_category'] ?? "Unknown";
            final String foodDescription =
                foodData['food_description'] ?? "No description provided";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final String base64Image = images[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            image: DecorationImage(
                              image: NetworkImage(base64Image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                                foodCategory,
                                style: AppTextStyle.w700(
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                foodName,
                                style: AppTextStyle.w700(
                                    fontSize: 12, color: AppColors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 15,
                              ),
                              2.sizeWidth,
                              Text(
                                "15-20 min",
                                style: AppTextStyle.w700(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      10.sizeHeight,
                      Text(
                        "₹$foodPrice",
                        style: AppTextStyle.w700(
                          fontSize: 16,
                        ),
                      ),
                      10.sizeHeight,
                      Text(
                        "Description",
                        style: AppTextStyle.w700(
                          fontSize: 18,
                        ),
                      ),
                      10.sizeHeight,
                      Text(
                        foodDescription,
                        style: AppTextStyle.w400(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 7,
                      ),
                      20.sizeHeight,
                      Center(
                        child: CommonButton(
                          onPressed: () async {
                            double quantity =
                                foodController.itemCount.toDouble();
                            setState(() {});
                            await cartController.addToCart(
                              foodId: foodId.toString(),
                              quantity: quantity.toDouble(),
                            );
                            AppSnackbar.showSuccess(
                                message: "Food successfully added to cart!");
                            NavigationServices.offAll(
                                () => const BottomNavigationBarScreen());
                          },
                          text: "Add To Cart",
                        ),
                      ),
                      20.sizeHeight,
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
