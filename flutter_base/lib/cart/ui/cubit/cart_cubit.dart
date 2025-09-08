import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.idle(cartTours: [], totalPrice: 0.0));

  static final log = Logger('CartCubit');

  void addToCart(Map<String, dynamic> tour, {int count = 1}) {
    try {
      // Emit loading state
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

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

      final newTotalPrice = _calculateTotalPrice(updatedCart);

      // Emit success state
      emit(
        CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
      );

      log.info('Tour added to cart: ${tour['title']} with quantity: $count');
    } catch (error) {
      // Emit error state if something goes wrong
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to add tour to cart: $error',
        ),
      );

      log.severe('Error adding tour to cart: $error');
    }
  }

  void removeTourFromCart(int tourId) {
    try {
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

      final updatedCart = state.cartTours
          .where((item) => item['id'] != tourId)
          .toList();

      final newTotalPrice = _calculateTotalPrice(updatedCart);

      emit(
        CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
      );

      log.info('Tour removed from cart: $tourId');
    } catch (error) {
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to remove tour from cart: $error',
        ),
      );

      log.severe('Error removing tour from cart: $error');
    }
  }

  void increaseTourCount(int tourId) {
    try {
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

      final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
      final index = updatedCart.indexWhere((item) => item['id'] == tourId);
      if (index != -1) {
        final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
        updatedItem['count']++;
        updatedCart[index] = updatedItem;

        final newTotalPrice = _calculateTotalPrice(updatedCart);

        emit(
          CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
        );
      } else {
        emit(
          CartState.error(
            cartTours: state.cartTours,
            totalPrice: state.totalPrice,
            errorMessage: 'Tour not found in cart',
          ),
        );
      }
    } catch (error) {
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to increase tour count: $error',
        ),
      );

      log.severe('Error increasing tour count: $error');
    }
  }

  void decreaseTourCount(int tourId) {
    try {
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

      final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
      final index = updatedCart.indexWhere((item) => item['id'] == tourId);
      if (index != -1 && updatedCart[index]['count'] > 1) {
        final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
        updatedItem['count']--;
        updatedCart[index] = updatedItem;

        final newTotalPrice = _calculateTotalPrice(updatedCart);

        emit(
          CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
        );
      } else if (index == -1) {
        emit(
          CartState.error(
            cartTours: state.cartTours,
            totalPrice: state.totalPrice,
            errorMessage: 'Tour not found in cart',
          ),
        );
      } else {
        // Count is already 1, cannot decrease further
        emit(
          CartState.success(
            cartTours: state.cartTours,
            totalPrice: state.totalPrice,
          ),
        );
      }
    } catch (error) {
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to decrease tour count: $error',
        ),
      );

      log.severe('Error decreasing tour count: $error');
    }
  }

  void toggleItemSelection(int tourId) {
    try {
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

      final updatedCart = List<Map<String, dynamic>>.from(state.cartTours);
      final index = updatedCart.indexWhere((item) => item['id'] == tourId);
      if (index != -1) {
        final isSelected = updatedCart[index]['isSelected'] as bool;
        updatedCart[index]['isSelected'] = !isSelected;

        final newTotalPrice = _calculateTotalPrice(updatedCart);

        emit(
          CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
        );
      } else {
        emit(
          CartState.error(
            cartTours: state.cartTours,
            totalPrice: state.totalPrice,
            errorMessage: 'Tour not found in cart',
          ),
        );
      }
    } catch (error) {
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to toggle item selection: $error',
        ),
      );

      log.severe('Error toggling item selection: $error');
    }
  }

  void toggleAll(bool isSelected) {
    try {
      emit(
        CartState.loading(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
        ),
      );

      final updatedCart = state.cartTours
          .map<Map<String, dynamic>>(
            (item) => {...item, 'isSelected': isSelected},
          )
          .toList();

      final newTotalPrice = _calculateTotalPrice(updatedCart);

      emit(
        CartState.success(cartTours: updatedCart, totalPrice: newTotalPrice),
      );
    } catch (error) {
      emit(
        CartState.error(
          cartTours: state.cartTours,
          totalPrice: state.totalPrice,
          errorMessage: 'Failed to toggle all items: $error',
        ),
      );

      log.severe('Error toggling all items: $error');
    }
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
  const factory CartState.idle({
    @Default([]) List<Map<String, dynamic>> cartTours,
    @Default(0.0) double totalPrice,
  }) = CartStateIdle;

  const factory CartState.loading({
    @Default([]) List<Map<String, dynamic>> cartTours,
    @Default(0.0) double totalPrice,
  }) = CartStateLoading;

  const factory CartState.success({
    @Default([]) List<Map<String, dynamic>> cartTours,
    @Default(0.0) double totalPrice,
  }) = CartStateSuccess;

  const factory CartState.error({
    @Default([]) List<Map<String, dynamic>> cartTours,
    @Default(0.0) double totalPrice,
    @Default('') String errorMessage,
  }) = CartStateError;
}
