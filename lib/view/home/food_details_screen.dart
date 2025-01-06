import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/controller/food_details_controller.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class FoodDetailsScreen extends StatelessWidget {
  FoodDetailsScreen({super.key});

  final FoodDetailsController controller =
      Get.put(FoodDetailsController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        text: "Food Details",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 350,
              child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        image: const DecorationImage(
                          image: AssetImage(
                            AppImages.Panjabi_thali,
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
                            "Gujarati Thali",
                            style: AppTextStyle.w700(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "Regular Thali",
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
                        "₹120",
                        style: AppTextStyle.w700(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
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
                            decoration: BoxDecoration(
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
                    "Experience the authentic flavors of Gujarat with our traditional Gujarati Thali! A wholesome platter featuring soft rotis, flavorful dal, spicy shaak, sweet shrikhand, tangy kadhi, and fluffy rice, accompanied by pickles and crispy papad. Perfect for a hearty and satisfying meal.",
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
        ),
      ),
    );
  }
}
