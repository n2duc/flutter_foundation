import 'package:flutter_demo/models/food.dart';

class CartItem {
  final Food food;
  final int quantity;
  final String id;

  CartItem({required this.food, required this.quantity, required this.id});

  CartItem copyWith({Food? food, int? quantity, String? id}) {
    return CartItem(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  double get totalPrice => food.price * quantity;
}
