import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';

class PlaceTypeItem extends StatelessWidget {
  const PlaceTypeItem({super.key, required this.item});

  final PlaceType item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(RFXSpacing.spacing14),
          decoration: BoxDecoration(
            color: RFXColors.lightPrimary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.getIcon(),
            size: RFXSpacing.spacing24,
            color: RFXColors.lightPrimary,
          ),
        ),
        const SizedBox(height: RFXSpacing.spacing8),
        Text(item.getName(), style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
