import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
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
  final List<Map<String, String>> foodItems = [
    {'name': 'Chicken Burger', 'price': '₹120', 'image': AppImages.page_2},
    {'name': 'Veg Pizza', 'price': '₹150', 'image': AppImages.page_4}, // Add your food data here
    {'name': 'Cheese Sandwich', 'price': '₹80', 'image': AppImages.burger},
    // Add more food items as required
  ];

  // For storing search query
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter the list based on search query
    final filteredFoodItems = foodItems
        .where((food) => food['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
                  ListView.builder(
                    itemCount: filteredFoodItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final food = filteredFoodItems[index];
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
                                        image: AssetImage(food['image']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          food['name']!,
                                          style: AppTextStyle.w700(
                                            fontSize: 18,
                                            color: AppColors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        10.sizeHeight,
                                        Text(
                                          "Price: ${food['price']}",
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
                                      Get.to(() => FoodDetailsScreen());
                                    },
                                    child: Text(
                                      "View",
                                      style: AppTextStyle.w700(fontSize: 16),
                                    ))),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
