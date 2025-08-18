import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TourCard extends StatefulWidget {
  const TourCard({super.key, required this.tour});

  final Map<String, dynamic> tour;

  @override
  State<TourCard> createState() => _TourCardState();
}

class _TourCardState extends State<TourCard> {
  final _isFavorite = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isFavorite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SizedBox(
        width: RFXSpacing.spacing240,
        child: Column(
          children: [
            Stack(
              children: [
                // border radius for image
                ClipRRect(
                  borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
                  child: Image.asset(
                    widget.tour['imgPath']!,
                    height: RFXSpacing.spacing280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: RFXSpacing.spacing12,
                  right: RFXSpacing.spacing12,
                  child: Container(
                    width: RFXSpacing.spacing32,
                    height: RFXSpacing.spacing32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _isFavorite,
                      builder: (context, value, _) {
                        return IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            value ? Iconsax.heart : Iconsax.heart_copy,
                            color: Colors.redAccent,
                            size: RFXSpacing.spacing20,
                          ),
                          onPressed: () {
                            _isFavorite.value = !_isFavorite.value;
                          },
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: RFXSpacing.spacing12,
                  left: RFXSpacing.spacing12,
                  // Using ClipRRect to apply border radius and backdrop filter to the rating container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: RFXSpacing.spacing6,
                        sigmaY: RFXSpacing.spacing6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: RFXColors.lightPrimary.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: RFXSpacing.spacing6,
                          vertical: RFXSpacing.spacing2,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: RFXColors.lightOnPrimary,
                              size: RFXSpacing.spacing20,
                            ),
                            const SizedBox(width: RFXSpacing.spacing6),
                            Text(
                              '${widget.tour['rating']}/5.0',
                              style: textTheme.bodyMedium?.copyWith(
                                color: RFXColors.lightOnPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: RFXSpacing.spacing12,
                horizontal: RFXSpacing.spacing4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.tour['title'], style: textTheme.titleMedium),
                  const SizedBox(height: RFXSpacing.spacing8),
                  Text(
                    widget.tour['description'],
                    style: textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: RFXSpacing.spacing8),
                  Text(
                    'Start from ${widget.tour['price']} VND / day',
                    style: textTheme.bodySmall?.copyWith(
                      color: RFXColors.lightPrimary,
                      fontWeight: FontWeight.bold,
                    ),
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
