import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const routeName = 'cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _isUseCoin = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
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
              ' (0)',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: RFXColors.lightPrimary,
              ),
            ),
          ],
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
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        padding: EdgeInsets.all(RFXSpacing.spacing12),
        child: const Center(child: Text('Your cart is empty')),
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
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.ticket_discount_copy,
                        size: RFXSpacing.spacing16,
                      ),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text('RFX Voucher'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Add voucher'),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Icon(
                        Iconsax.arrow_right_3_copy,
                        size: RFXSpacing.spacing16,
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
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
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
                        size: RFXSpacing.spacing16,
                      ),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text('Use 10.000 RFX Coin'),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Icon(
                        Iconsax.message_question_copy,
                        size: RFXSpacing.spacing16,
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
            Container(
              padding: EdgeInsets.symmetric(
                vertical: RFXSpacing.spacing12,
                horizontal: RFXSpacing.spacing16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text('Select all'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
