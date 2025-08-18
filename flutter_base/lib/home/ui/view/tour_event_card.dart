import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class TourEventCard extends StatelessWidget {
  const TourEventCard({required this.event, required this.onTap, super.key});

  final Map<String, dynamic> event;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          side: BorderSide.none, //
          borderRadius: BorderRadius.all(Radius.circular(RFXSpacing.small)),
        ),
        color: RFXColors.lightOnPrimary,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RFXSpacing.small),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: RFXSpacing.spacing6,
              vertical: RFXSpacing.spacing6,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(RFXSpacing.spacing6),
                  child: Image.asset(
                    event['imgPath']!,
                    width: RFXSpacing.spacing52,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: RFXSpacing.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        event['title'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: RFXColors.lightPrimary, //
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        event['description'],
                        style: Theme.of(context).textTheme.bodySmall, //
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
