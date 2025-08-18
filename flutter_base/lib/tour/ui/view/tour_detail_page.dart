import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TourDetailPage extends StatelessWidget {
  const TourDetailPage({super.key, required this.tour});

  static const routeName = 'tour_detail';
  final Map<String, dynamic> tour;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(RFXSpacing.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
