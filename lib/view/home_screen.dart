import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Drawer Example"),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(
          "Main Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      "assets/images/person.jpg"), // Replace with your asset
                ),
                SizedBox(height: 10),
                Text(
                  "Sahil Sorathiya",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Drawer Items
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  icon: Icons.home,
                  text: "Home",
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                DrawerItem(
                  icon: Icons.person,
                  text: "Profile",
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.settings,
                  text: "Settings",
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.notifications,
                  text: "Notifications",
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.logout,
                  text: "Logout",
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            ),
          ),
          // Footer
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
