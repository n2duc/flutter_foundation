import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';

class PlaceTypeItem extends StatelessWidget {
  const PlaceTypeItem({required this.item, required this.maxWidth, super.key});

  final PlaceType item;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Change use Icon button
        Container(
          decoration: BoxDecoration(
            color: RFXColors.lightPrimary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: const EdgeInsets.all(RFXSpacing.spacing14),
            onPressed: () {
              ///If has api handle extension for PlaceType
              item.navigate(context);
            },
            icon: Icon(
              item.getIcon(),
              size: RFXSpacing.spacing24,
              color: RFXColors.lightPrimary,
            ),
            color: RFXColors.lightPrimary.withValues(alpha: 0.1),
          ),
        ),

        const SizedBox(height: RFXSpacing.spacing8),
        SizedBox(
          width: maxWidth,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              item.getName(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
