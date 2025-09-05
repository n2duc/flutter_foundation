import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  static final log = Logger('CartCubit');

  void addToCart(Map<String, dynamic> tour, {int count = 1}) {
    final List<Map<String, dynamic>> updatedCart = List.from(state.cartTours);
    final int index = updatedCart.indexWhere(
      (item) => item['id'] == tour['id'],
    );

    if (index != -1) {
      final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
      updatedItem['count'] += count;
      updatedCart[index] = updatedItem;
    } else {
      updatedCart.add({...tour, 'count': count, 'isSelected': false});
    }

    emit(
      state.copyWith(
        cartTours: updatedCart,
        totalPrice: _calculateTotalPrice(updatedCart),
      ),
    );

    log.info('Tour added to cart: ${tour['title']} with quantity: $count');
  }

  void removeTourFromCart(int tourId) {
    final updatedCart = state.cartTours
        .where((item) => item['id'] != tourId)
        .toList();
    emit(
      state.copyWith(
        cartTours: updatedCart,
        totalPrice: _calculateTotalPrice(updatedCart),
      ),
    );

    log.info('Tour removed from cart: $tourId');
  }

  void increaseTourCount(int tourId) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
    final index = updatedCart.indexWhere((item) => item['id'] == tourId);
    if (index != -1) {
      final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
      updatedItem['count']++;
      updatedCart[index] = updatedItem;

      emit(
        state.copyWith(
          cartTours: updatedCart,
          totalPrice: _calculateTotalPrice(updatedCart),
        ),
      );
    }
  }

  void decreaseTourCount(int tourId) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
    final index = updatedCart.indexWhere((item) => item['id'] == tourId);
    if (index != -1 && updatedCart[index]['count'] > 1) {
      final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
      updatedItem['count']--;
      updatedCart[index] = updatedItem;

      emit(
        state.copyWith(
          cartTours: updatedCart,
          totalPrice: _calculateTotalPrice(updatedCart),
        ),
      );
    }
  }

  void toggleItemSelection(int tourId) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
    final index = updatedCart.indexWhere((item) => item['id'] == tourId);
    if (index != -1) {
      final isSelected = updatedCart[index]['isSelected'] as bool;
      updatedCart[index]['isSelected'] = !isSelected;
      emit(
        state.copyWith(
          cartTours: updatedCart,
          totalPrice: _calculateTotalPrice(updatedCart),
        ),
      );
    }
  }

  void toggleAll(bool isSelected) {
    final updatedCart = state.cartTours
        .map<Map<String, dynamic>>(
          (item) => {...item, 'isSelected': isSelected},
        )
        .toList();
    emit(
      state.copyWith(
        cartTours: updatedCart,
        totalPrice: _calculateTotalPrice(updatedCart),
      ),
    );
  }

  double _calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    return cartItems
        .where((item) => item['isSelected'] == true)
        .fold(
          0.0,
          (sum, item) =>
              sum +
              (double.tryParse(item['price'].toString())! * item['count']),
        );
  }
}

@freezed
sealed class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<Map<String, dynamic>> cartTours,
    @Default(0.0) double totalPrice,
  }) = _CartState;
}
