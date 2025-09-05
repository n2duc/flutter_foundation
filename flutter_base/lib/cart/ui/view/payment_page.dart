import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
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
              child: Row(
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
                  Icon(Iconsax.arrow_right_3_copy, size: RFXSpacing.spacing18),
                ],
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
