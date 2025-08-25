import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TourDetailPage extends StatelessWidget {
  const TourDetailPage({super.key, required this.tour});

  static const routeName = 'tour_detail';
  final Map<String, dynamic> tour;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: RFXSpacing.spacing240,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(tour['imgPath']!, fit: BoxFit.cover),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: RFXSpacing.spacing16),
              child: Container(
                width: RFXSpacing.spacing40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: RFXColors.lightOnPrimary,
                ),
                child: IconButton(
                  icon: const Icon(Iconsax.arrow_left_2_copy),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: RFXSpacing.spacing16),
                child: Container(
                  width: RFXSpacing.spacing40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: RFXColors.lightOnPrimary,
                  ),
                  child: IconButton(
                    icon: const Icon(Iconsax.heart, color: Colors.redAccent),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: RFXSpacing.spacing20,
                vertical: RFXSpacing.spacing24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingStars(
                        rating: tour['rating']!,
                        starSize: RFXSpacing.spacing20,
                      ),
                      const SizedBox(width: RFXSpacing.spacing12),
                      Text('${tour['rating']}/5.0'),
                    ],
                  ),
                  const SizedBox(height: RFXSpacing.spacing12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tour['title'],
                        style: textTheme.titleLarge?.copyWith(
                          color: RFXColors.lightPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.messages_1,
                          color: RFXColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: RFXSpacing.spacing12),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        color: RFXColors.lightPrimary,
                        size: RFXSpacing.spacing18,
                      ),
                      const SizedBox(width: RFXSpacing.spacing4),
                      Text(
                        tour['location'],
                        style: textTheme.bodyMedium?.copyWith(
                          color: RFXColors.lightPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: RFXSpacing.spacing6),
                  Text(tour['description'], style: textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: RFXSpacing.spacing20,
          right: RFXSpacing.spacing20,
          top: RFXSpacing.spacing16,
        ),
        decoration: BoxDecoration(
          color: RFXColors.lightPrimary.withValues(alpha: 0.1),
          border: Border(
            top: BorderSide(
              color: RFXColors.lightPrimary.withValues(alpha: 0.1),
              width: RFXSpacing.spacing2,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize:
                    MainAxisSize.min, // This makes the column size to content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Place'),
                  Text(
                    '\$${tour['price']} / day',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RFXPrimaryButton.large(onPressed: () {}, title: "Book Now"),
            ],
          ),
        ),
      ),
    );
  }
}
