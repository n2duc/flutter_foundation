import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      bloc: getIt<CartCubit>(),
      selector: (state) => state.cartTours.length,
      builder: (context, cartCount) {
        return Stack(
          children: [
            Container(
              width: RFXSpacing.spacing40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: RFXColors.lightOnPrimary,
              ),
              child: IconButton(
                icon: const Icon(
                  Iconsax.shopping_cart,
                  size: RFXSpacing.spacing20,
                  color: RFXColors.lightPrimary,
                ),
                onPressed: () => context.pushNamed(CartPage.routeName),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: RFXSpacing.spacing2,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
                ),
                constraints: BoxConstraints(
                  minWidth: RFXSpacing.spacing18,
                  minHeight: RFXSpacing.spacing18,
                ),
                child: Text(
                  '$cartCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: RFXSpacing.spacing12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
