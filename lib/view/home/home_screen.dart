import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/category_controller.dart';
import 'package:food_hub_user/controller/get_user_info_controller.dart';
import 'package:food_hub_user/core/const/images.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/view/home/food_screen.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/const/colors.dart';
import '../../core/const/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetUserInfoController _getUserController =
      Get.put(GetUserInfoController());

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final List<String> foodImages = [
      AppImages.page_1,
      AppImages.page_2,
      AppImages.page_3,
      AppImages.page_4,
    ];

    var userData = _getUserController.userData;
    final CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Obx(() => Text(
              "Welcome ${userData["name"] ?? "Loading...."}!",
              style: AppTextStyle.w600(color: AppColors.white, fontSize: 19),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sizeHeight,
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                itemCount: foodImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black, width: 3),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(foodImages[index]),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: foodImages.length,
                effect: const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.orange,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "All Categories",
                    style: AppTextStyle.w700(fontSize: 20),
                  ),
                ],
              ),
            ),
            10.sizeHeight,
            SizedBox(
              width: double.infinity,
              height: 130,
              child: Obx(
                () => controller.categories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FoodScreen(
                                      foodCategory: category['category_name'],
                                    ));
                              },
                              child: Container(
                                height: 100,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                category['image_url']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        category['category_name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            10.sizeHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today Special",
                    style: AppTextStyle.w700(fontSize: 20),
                  ),
                ],
              ),
            ),
            10.sizeHeight,
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      children: [
                        Card(
                          color: Colors.black,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: 80,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          AppImages.burger,
                                        ),
                                        fit: BoxFit.cover),
                                    border: Border.all(color: AppColors.white),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Chicken Burger",
                                          style: AppTextStyle.w700(
                                              color: AppColors.white,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          "₹120",
                                          style: AppTextStyle.w700(
                                            color: AppColors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 12,
                          child: Container(
                            height: 35,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "View",
                                style: AppTextStyle.w700(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
