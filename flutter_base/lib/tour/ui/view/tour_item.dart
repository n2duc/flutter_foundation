import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class TourItem extends StatelessWidget {
  const TourItem({super.key, required this.tour, this.onTap});

  final Map<String, dynamic> tour;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: RFXSpacing.spacing24,
        vertical: RFXSpacing.spacing6,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                size: RFXSpacing.spacing16,
                color: RFXColors.lightPrimary,
              ),
              const SizedBox(width: RFXSpacing.extraSmall),
              Text(
                '${tour['rating']}/5.0',
                style: textTheme.bodySmall?.copyWith(
                  color: RFXColors.lightPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: RFXSpacing.extraSmall),
              Text('(36.000)', style: textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: RFXSpacing.extraSmall),
          Text(tour['title'], style: textTheme.titleSmall),
        ],
      ),
      subtitle: Text(
        tour['description'],
        style: textTheme.bodySmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
        child: Image.asset(
          tour['imgPath'],
          width: RFXSpacing.spacing60,
          fit: BoxFit.cover,
        ),
      ),
      onTap: onTap,
    );
  }
}
