import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/cart/cart_state.dart';
import 'package:flutter_demo/models/cart_item.dart';
import 'package:flutter_demo/models/food.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  void addFoodToCart(Food food, int quantity) {
    List<CartItem> updatedItems = [];

    if (state is CartLoaded) {
      updatedItems = List.from((state as CartLoaded).items);
    }

    // Check if item already exists
    final existingItemIndex = updatedItems.indexWhere(
      (item) => item.food.name == food.name,
    );

    if (existingItemIndex >= 0) {
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      updatedItems.add(
        CartItem(
          food: food,
          quantity: quantity,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );
    }

    emit(CartLoaded(items: updatedItems));
  }

  void removeFoodFromCart(String foodId) {
    if (state is CartLoaded) {
      final updatedItems = (state as CartLoaded).items
          .where((item) => item.food.name != foodId)
          .toList();
      emit(CartLoaded(items: updatedItems));
    }
  }

  void updateFoodQuantity(String foodId, int quantity) {
    if (state is CartLoaded) {
      final updatedItems = (state as CartLoaded).items
          .map((item) {
            if (item.food.name == foodId) {
              if (quantity <= 0) return null; // remove if <= 0
              return item.copyWith(quantity: quantity);
            }
            return item;
          })
          .where((item) => item != null)
          .cast<CartItem>()
          .toList();

      emit(CartLoaded(items: updatedItems));
    }
  }

  void clearCart() {
    emit(const CartLoaded(items: []));
  }
}
