import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    final List<String> foodImages = [
      AppImages.page_1,
      AppImages.page_2,
      AppImages.page_3,
      AppImages.page_4,
    ];

    final List<String> categories_Images = [
      AppImages.Gujarati_thali,
      AppImages.paneer_Sabji,
      AppImages.Panjabi_thali,
      AppImages.Cold_drink,
    ];
    final List<String> categories_Name = [
      "Gujarati Thali",
      "Paneer Sabzi",
      "Panjabi Thali",
      "Cold Drink",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        text: "Welcome Sahil Sorathiya!",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sizeHeight,
            // Wrap the PageView with a fixed height Container
            SizedBox(
              height: 200, // Set an appropriate height
              child: PageView.builder(
                controller: _pageController,
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
                controller: _pageController,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Categories",
                    style: AppTextStyle.w700(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All >",
                      style: AppTextStyle.w700(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories_Images.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                          color: AppColors.black,
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
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        categories_Images[index],
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              10.sizeHeight,
                              Text(
                                categories_Name[index],
                                style: AppTextStyle.w700(color: AppColors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today Special",
                    style: AppTextStyle.w700(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All >",
                      style: AppTextStyle.w700(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),

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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Chicken Burger",
                                          style: AppTextStyle.w700(
                                              color: AppColors.white, fontSize: 17),
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
                                  ))),
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
