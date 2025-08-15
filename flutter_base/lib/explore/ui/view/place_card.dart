import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place});

  final Map<String, dynamic> place;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: RFXSpacing.spacing6,
        horizontal: 0,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
        child: Image.asset(
          place['imgPath'],
          width: RFXSpacing.spacing56,
          height: RFXSpacing.spacing56,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        place['title'],
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: RFXColors.lightPrimary,
        ),
      ),
      subtitle: Text(place['location'], style: textTheme.bodySmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Iconsax.location,
            color: RFXColors.lightPrimary,
            size: RFXSpacing.spacing16,
          ),
          const SizedBox(width: RFXSpacing.small),
          Text('100 places', style: textTheme.bodySmall),
        ],
      ),
      onTap: () {
        // TODO: navigate to detail when implemented
      },
    );
  }
}
