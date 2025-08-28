import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TourBookingSheet extends StatefulWidget {
  const TourBookingSheet({super.key, required this.tour});

  final Map<String, dynamic> tour;

  @override
  State<TourBookingSheet> createState() => _TourBookingSheetState();
}

class _TourBookingSheetState extends State<TourBookingSheet> {
  final ValueNotifier<int> _quantityCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    _quantityCount.dispose();
    super.dispose();
  }

  void incrementQuantity() {
    _quantityCount.value++;
  }

  void decrementQuantity() {
    if (_quantityCount.value > 0) {
      _quantityCount.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RFXSpacing.spacing28),
          ),
        ),
        padding: const EdgeInsets.only(
          top: RFXSpacing.spacing16,
          left: RFXSpacing.spacing20,
          right: RFXSpacing.spacing20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: RFXSpacing.spacing4,
              width: RFXSpacing.spacing52,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(RFXSpacing.spacing2),
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing16),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tour['title'],
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: RFXSpacing.spacing4),
                  Text(
                    '\$${widget.tour['price']} person / day',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Text(
              widget.tour['description'],
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: RFXSpacing.spacing20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: const Icon(
                          Icons.remove,
                          size: RFXSpacing.spacing16,
                        ),
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _quantityCount,
                        builder: (context, value, _) {
                          return SizedBox(
                            width: RFXSpacing.spacing40,
                            child: Center(
                              child: Text('$value', style: textTheme.bodyLarge),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: const Icon(Icons.add, size: RFXSpacing.spacing16),
                        highlightColor: RFXColors.lightPrimary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: RFXSpacing.spacing16),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: [10, 5],
                strokeWidth: 1,
                radius: Radius.circular(RFXSpacing.spacing10),
                color: RFXColors.lightPrimary,
                padding: const EdgeInsets.symmetric(
                  vertical: RFXSpacing.spacing12,
                  horizontal: RFXSpacing.spacing12,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.ticket_star,
                    color: RFXColors.lightPrimary,
                  ),
                  const SizedBox(width: RFXSpacing.spacing8),
                  Text(
                    'Add voucher or promote code',
                    style: textTheme.bodyMedium?.copyWith(
                      color: RFXColors.lightPrimary,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Iconsax.arrow_right_3_copy,
                    color: RFXColors.lightPrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing16),
            SizedBox(
              width: double.infinity,
              child: RFXPrimaryButton.large(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
