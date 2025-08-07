import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/about_page.dart';
import 'package:flutter_demo/pages/cart_page.dart';
import 'package:flutter_demo/pages/food_detail_page.dart';
import 'package:flutter_demo/components/food_item.dart';
import 'package:flutter_demo/components/food_sheet.dart';
import 'package:flutter_demo/models/food.dart';
import 'package:flutter_demo/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List foodMenu = [
    Food(
      name: 'Sushi Salmon Eggs',
      description:
          'The favorite sushi of the Japanese people and the most delicious sushi in the world.',
      rating: 4.5,
      reviews: 120,
      image: 'lib/images/nigiri.png',
      price: 12.99,
    ),
    Food(
      name: 'Premium Uramaki Roll',
      description:
          'Fresh salmon and avocado wrapped in seasoned rice and crispy nori seaweed.',
      rating: 4.8,
      reviews: 95,
      image: 'lib/images/uramaki.png',
      price: 15.50,
    ),
    Food(
      name: 'Classic Sushi Platter',
      description:
          'A variety of fresh sushi pieces including salmon, tuna, and shrimp nigiri.',
      rating: 4.3,
      reviews: 200,
      image: 'lib/images/sushi.png',
      price: 24.99,
    ),
    Food(
      name: 'Dragon Roll Special',
      description:
          'Tempura shrimp and cucumber topped with sliced avocado and special sauce.',
      rating: 4.7,
      reviews: 85,
      image: 'lib/images/sushi (1).png',
      price: 18.75,
    ),
  ];

  void _showAddFoodBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FoodSheet(
        onAddFood: (food) {
          setState(() {
            foodMenu.add(food);
          });
        },
      ),
    );
  }

  void _navigateToFoodDetail(int index) {
    context.push('/${FoodDetailPage.routeName}', extra: foodMenu[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Sushi Man',
          style: GoogleFonts.dmSerifDisplay(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => context.push('/${AboutPage.routeName}'),
          icon: Icon(Icons.info, color: Colors.white, size: 24),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/${CartPage.routeName}'),
            icon: Icon(Icons.shopping_cart, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Search', style: GoogleFonts.dmSerifDisplay(fontSize: 16)),
                const SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Popular Foods',
            style: GoogleFonts.dmSerifDisplay(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: foodMenu.length,
              itemBuilder: (context, index) => FoodItem(
                food: foodMenu[index],
                onTap: () {
                  _navigateToFoodDetail(index);
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: _showAddFoodBottomSheet,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
