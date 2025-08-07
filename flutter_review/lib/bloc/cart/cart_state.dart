import 'package:equatable/equatable.dart';
import 'package:flutter_demo/models/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded({required this.items});

  @override
  List<Object> get props => [items];

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  CartItem? getItemById(String foodId) {
    try {
      return items.firstWhere((item) => item.food.name == foodId);
    } catch (e) {
      return null;
    }
  }
}
