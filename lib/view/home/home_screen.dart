import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                children: [
                  CategoryCard(icon: Icons.lunch_dining, label: "Burger"),
                  CategoryCard(icon: Icons.cake, label: "Donut"),
                  CategoryCard(icon: Icons.local_pizza, label: "Pizza"),
                ],
              ),

              SizedBox(height: 20),

              // Featured Restaurants
              Text(
                "Featured Restaurants",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              RestaurantCard(
                imageUrl: "https://via.placeholder.com/150",
                name: "McDonald's",
                rating: "4.5",
                delivery: "Free delivery",
                tags: ["BURGER", "CHICKEN"],
              ),

              SizedBox(height: 20),

              // Popular Items
              Text(
                "Popular Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              RestaurantCard(
                imageUrl: "https://via.placeholder.com/150",
                name: "Chicken Wings",
                rating: "4.8",
                delivery: "\$5.50",
                tags: ["SPICY", "HOT"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orangeAccent.shade100,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rating;
  final String delivery;
  final List<String> tags;

  const RestaurantCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.delivery,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text(rating,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(delivery, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: tags
                        .map((tag) => Chip(
                              label: Text(tag,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
