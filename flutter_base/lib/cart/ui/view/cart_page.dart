import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const routeName = 'cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _isUseCoin = ValueNotifier<bool>(false);

  final _bloc = getIt<CartCubit>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: Colors.grey.shade300, height: 0.5),
        ),
        title: BlocSelector<CartCubit, CartState, int>(
          bloc: _bloc,
          selector: (state) => state.cartTours.length,
          builder: (context, cartCount) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Shopping cart',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: RFXColors.lightPrimary,
                  ),
                ),
                Text(
                  ' ($cartCount)',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: RFXColors.lightPrimary,
                  ),
                ),
              ],
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_copy,
            color: RFXColors.lightPrimary,
            size: RFXSpacing.spacing24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: RFXSpacing.spacing12),
            child: IconButton(
              icon: const Icon(Iconsax.message, color: RFXColors.lightPrimary),
              onPressed: () {},
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: BlocSelector<CartCubit, CartState, List<Map<String, dynamic>>>(
          bloc: _bloc,
          selector: (state) => state.cartTours,
          builder: (context, cartTours) {
            if (cartTours.isEmpty) {
              return Center(
                child: Text(
                  'Your cart is empty',
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              );
            }
            return SlidableAutoCloseBehavior(
              child: ListView.separated(
                padding: const EdgeInsets.all(RFXSpacing.spacing12),
                itemCount: cartTours.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: RFXSpacing.spacing12),
                itemBuilder: (context, index) {
                  final tour = cartTours[index];
                  return CartItemCard(tour: tour);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: RFXSpacing.spacing12,
                horizontal: RFXSpacing.spacing16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.ticket_discount_copy,
                        size: RFXSpacing.spacing18,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text('RFX Voucher'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Select or promo code',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Icon(
                        Iconsax.arrow_right_3_copy,
                        size: RFXSpacing.spacing18,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: RFXSpacing.spacing12,
                horizontal: RFXSpacing.spacing16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.dollar_circle_copy,
                        size: RFXSpacing.spacing18,
                        color: RFXColors.lightSecondaryFixedDim,
                      ),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text('Use 10.000 RFX Coin'),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Icon(
                        Iconsax.message_question_copy,
                        size: RFXSpacing.spacing18,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  AdvancedSwitch(
                    height: RFXSpacing.spacing24,
                    width: RFXSpacing.spacing40,
                    controller: _isUseCoin,
                  ),
                ],
              ),
            ),
            BlocSelector<CartCubit, CartState, double>(
              bloc: _bloc,
              selector: (state) => state.totalPrice,
              builder: (context, totalPrice) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: RFXSpacing.spacing12,
                    horizontal: RFXSpacing.spacing18,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocSelector<CartCubit, CartState, bool>(
                            bloc: _bloc,
                            selector: (state) =>
                                state.cartTours.isNotEmpty &&
                                state.cartTours.every(
                                  (item) => item['isSelected'] == true,
                                ),
                            builder: (context, isAllSelected) {
                              return InkWell(
                                onTap: () {
                                  _bloc.toggleAll(!isAllSelected);
                                },
                                child: Row(
                                  children: [
                                    RFXCheckbox(
                                      value: isAllSelected,
                                      onChanged: () {
                                        _bloc.toggleAll(!isAllSelected);
                                      },
                                    ),
                                    const SizedBox(width: RFXSpacing.spacing6),
                                    Text('Select all'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: RFXColors.lightPrimary,
                            ),
                          ),
                          const SizedBox(width: RFXSpacing.spacing8),
                          RFXPrimaryButton.small(
                            title: 'Buy now',
                            onPressed: () {
                              context.pushNamed(PaymentPage.routeName);
                            },
                            disabled: totalPrice <= 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
