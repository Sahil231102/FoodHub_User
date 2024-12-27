import 'package:flutter/material.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu, color: Colors.black), // Hamburger menu icon
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "4102 Pts",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "What would you like to order",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 16),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Find for food and restaurant",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Categories (Burger, Donut, etc.)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),

              SizedBox(height: 20),

              // Featured Restaurants
              Text(
                "Featured Restaurants",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              SizedBox(height: 20),

              AuthCommanButton(
                text: "logout",
                onTap: () {
                  box.write("isLoggedIn", false);
                  Get.to(() => LoginScreen());
                },
              ),
              // Popular Items
              Text(
                "Popular Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
