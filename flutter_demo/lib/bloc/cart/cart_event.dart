import 'package:equatable/equatable.dart';
import 'package:flutter_demo/models/food.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddFoodToCart extends CartEvent {
  final Food food;
  final int quantity;

  const AddFoodToCart({required this.food, this.quantity = 1});

  @override
  List<Object> get props => [food, quantity];
}

class RemoveFoodFromCart extends CartEvent {
  final String foodId;

  const RemoveFoodFromCart({required this.foodId});

  @override
  List<Object> get props => [foodId];
}

class UpdateFoodQuantity extends CartEvent {
  final String foodId;
  final int quantity;

  const UpdateFoodQuantity({required this.foodId, required this.quantity});

  @override
  List<Object> get props => [foodId, quantity];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
