import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/view/home/account_screen.dart';
import 'package:food_hub_user/view/home/cart_screen.dart';
import 'package:food_hub_user/view/home/food_screen.dart';
import 'package:food_hub_user/view/home/home_screen.dart';
import 'package:food_hub_user/view/home/order_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    const HomeScreen(),
    const FoodScreen(),
    const CartScreen(),
    const OrderScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Checkout",
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.bookmark_border),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person_2),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.black,
        selectedIconTheme: const IconThemeData(
          size: 30,
          color: AppColors.primary,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
