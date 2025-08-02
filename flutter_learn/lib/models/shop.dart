import 'package:flutter/material.dart';

import 'food.dart';

class Shop extends ChangeNotifier {
  final List<Food> _foodMenu = [
    Food(
      name: "Salmon Sushi",
      price: "22.00",
      imagePath: "lib/images/salmon_sushi.png",
      rating: "4.5",
    ),
    Food(
      name: "Salmon Eggs",
      price: "18.00",
      imagePath: "lib/images/salmon_eggs.png",
      rating: "5.0",
    ),
  ];

  final List<Food> _cart = [];

  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;

  void addToCart(Food food, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(food);
    }
    notifyListeners();
  }

  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }
}