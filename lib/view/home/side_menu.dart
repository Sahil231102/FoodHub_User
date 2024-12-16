import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';

class AnimatedSideMenu extends StatefulWidget {
  @override
  _AnimatedSideMenuState createState() => _AnimatedSideMenuState();
}

class _AnimatedSideMenuState extends State<AnimatedSideMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  void toggleMenu() {
    setState(() {
      if (isMenuOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double menuWidth = MediaQuery.of(context).size.width * 0.7;
    final double menuHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Side Menu
          Container(
            width: menuWidth,
            height: menuHeight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            "https://cgfaces.com/collection/1024px/9f19a02b-a5f0-4bb8-a58b-d03ffc5ffd35.jpg"), // Replace with actual image URL
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Farion Wick",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "farionwick@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Menu Items
                  MenuItem(icon: Icons.list_alt, text: "My Orders"),
                  MenuItem(icon: Icons.person, text: "My Profile"),
                  MenuItem(icon: Icons.location_on, text: "Delivery Address"),
                  MenuItem(icon: Icons.payment, text: "Payment Methods"),
                  MenuItem(icon: Icons.contact_mail, text: "Contact Us"),
                  MenuItem(icon: Icons.settings, text: "Settings"),
                  MenuItem(icon: Icons.help_outline, text: "Helps & FAQs"),
                  Spacer(),
                  // Log Out Button
                  GestureDetector(
                    onTap: () {
                      // Handle Log Out
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Container(
                          height: 43,
                          width: 117,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                                  child: Icon(
                                    Icons.power_settings_new_sharp,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Log Out",
                                  style: AppTextStyle.w600(color: AppColors.white, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content with Animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double slide = menuWidth * _controller.value;
              double scale = 1 - (0.2 * _controller.value);

              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (isMenuOpen) toggleMenu();
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Home Screen"),
                      leading: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: toggleMenu,
                      ),
                    ),
                    body: Center(
                      child: Text(
                        "Main Content",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  MenuItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
