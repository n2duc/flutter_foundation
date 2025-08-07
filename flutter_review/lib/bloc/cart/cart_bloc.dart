import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/cart/cart_event.dart';
import 'package:flutter_demo/bloc/cart/cart_state.dart';
import 'package:flutter_demo/models/cart_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<AddFoodToCart>(_onAddFoodToCart);
    on<RemoveFoodFromCart>(_onRemoveFoodFromCart);
    on<UpdateFoodQuantity>(_onUpdateFoodQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddFoodToCart(AddFoodToCart event, Emitter<CartState> emit) {
    final currentState = state;
    List<CartItem> updatedItems = [];

    if (currentState is CartLoaded) {
      updatedItems = List.from(currentState.items);
    }

    // Check if item already exists in cart
    final existingItemIndex = updatedItems.indexWhere(
      (item) => item.food.name == event.food.name,
    );

    if (existingItemIndex >= 0) {
      // Update quantity of existing item
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
    } else {
      // Add new item to cart
      updatedItems.add(
        CartItem(
          food: event.food,
          quantity: event.quantity,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );
    }

    emit(CartLoaded(items: updatedItems));
  }

  void _onRemoveFoodFromCart(
    RemoveFoodFromCart event,
    Emitter<CartState> emit,
  ) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = currentState.items
          .where((item) => item.food.name != event.foodId)
          .toList();
      emit(CartLoaded(items: updatedItems));
    }
  }

  void _onUpdateFoodQuantity(
    UpdateFoodQuantity event,
    Emitter<CartState> emit,
  ) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = currentState.items
          .map((item) {
            if (item.food.name == event.foodId) {
              if (event.quantity <= 0) {
                return null; // Will be filtered out
              }
              return item.copyWith(quantity: event.quantity);
            }
            return item;
          })
          .where((item) => item != null)
          .cast<CartItem>()
          .toList();

      emit(CartLoaded(items: updatedItems));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartLoaded(items: []));
  }
}
