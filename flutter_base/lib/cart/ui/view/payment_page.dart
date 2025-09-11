import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static const routeName = 'payment';

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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Payment',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: RFXColors.lightPrimary,
          ),
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
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        padding: const EdgeInsets.all(RFXSpacing.spacing12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
              padding: const EdgeInsets.all(RFXSpacing.spacing12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.location,
                        size: RFXSpacing.spacing18,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(width: RFXSpacing.spacing8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nguyen Ngoc Duc',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: RFXColors.lightPrimary,
                              ),
                            ),
                            const SizedBox(height: RFXSpacing.spacing2),
                            Text('+84 123 456 789', style: textTheme.bodySmall),
                            const SizedBox(height: RFXSpacing.spacing2),
                            Text(
                              '123, ABC Street, City, Country',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Iconsax.arrow_right_3_copy,
                        size: RFXSpacing.spacing16,
                      ),
                    ],
                  ),
                  const SizedBox(height: RFXSpacing.spacing12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.wallet_copy,
                            size: RFXSpacing.spacing16,
                            color: RFXColors.lightPrimary,
                          ),
                          const SizedBox(width: RFXSpacing.spacing8),
                          Text(
                            'Identity information',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('*****1234', style: textTheme.bodySmall),
                          const SizedBox(width: RFXSpacing.spacing6),
                          Icon(
                            Iconsax.arrow_right_3_copy,
                            size: RFXSpacing.spacing16,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: RFXSpacing.spacing12,
                      left: RFXSpacing.spacing12,
                      top: RFXSpacing.spacing12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.shop_copy,
                          size: RFXSpacing.spacing16,
                          color: RFXColors.lightPrimary,
                        ),
                        const SizedBox(width: RFXSpacing.spacing8),
                        Text(
                          'Order info',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: RFXColors.lightPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: RFXSpacing.spacing12,
                      vertical: RFXSpacing.spacing12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(
                              RFXSpacing.spacing8,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              RFXSpacing.spacing6,
                            ),
                            child: Image.asset(
                              'assets/images/hanoi.jpg',
                              width: RFXSpacing.spacing100,
                              height: RFXSpacing.spacing80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: RFXSpacing.spacing12),
                        Expanded(
                          child: SizedBox(
                            height: RFXSpacing.spacing80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Hanoi City Tour',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: RFXColors.lightPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'A beautiful cruise through the limestone islands of Ha Long Bay',
                                  style: textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$200.00',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: RFXColors.lightPrimary,
                                      ),
                                    ),
                                    Text(' x1', style: textTheme.bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: RFXSpacing.spacing8,
                      horizontal: RFXSpacing.spacing12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total (for 1 item)',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$200.00',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: RFXColors.lightPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
              padding: const EdgeInsets.all(RFXSpacing.spacing12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: RFXColors.lightPrimary,
                    ),
                  ),
                  const SizedBox(height: RFXSpacing.spacing12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.wallet_copy,
                            size: RFXSpacing.spacing16,
                            color: RFXColors.lightPrimary,
                          ),
                          const SizedBox(width: RFXSpacing.spacing8),
                          Text('Credit/Debit Card', style: textTheme.bodySmall),
                        ],
                      ),
                      Icon(
                        Iconsax.arrow_right_3_copy,
                        size: RFXSpacing.spacing16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: RFXSpacing.spacing8),
                      Text('**** **** **** 1234', style: textTheme.bodySmall),
                    ],
                  ),
                  PaymentMethodRadio(),
                ],
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
              padding: const EdgeInsets.all(RFXSpacing.spacing12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: RFXColors.lightPrimary,
                    ),
                  ),
                  const SizedBox(height: RFXSpacing.spacing12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Subtotal'), Text('\$200.00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Booking fee'), Text('\$10.00')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'),
                      Text(
                        '-\$10.00',
                        style: textTheme.bodyMedium?.copyWith(
                          color: RFXColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: RFXSpacing.spacing8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: RFXSpacing.spacing8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text(
                          '\$200.00',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: RFXColors.lightPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  text:
                      'By clicking "Order now", you agree to comply with the RFX ',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade800,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: textTheme.bodySmall?.copyWith(
                        color: RFXColors.lightPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: RFXSpacing.spacing12,
            horizontal: RFXSpacing.spacing20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('Total', style: textTheme.bodyMedium),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text(
                        '\$100.000',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: RFXColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Saving', style: textTheme.bodySmall),
                      const SizedBox(width: RFXSpacing.spacing6),
                      Text(
                        '\$50.000',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: RFXColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: RFXSpacing.spacing12),
              RFXPrimaryButton.small(title: 'Order now', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
