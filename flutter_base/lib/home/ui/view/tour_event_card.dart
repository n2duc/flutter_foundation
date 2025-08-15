import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class TourEventCard extends StatelessWidget {
  const TourEventCard({super.key, required this.event});

  final Map<String, dynamic> event;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: Card(
        elevation: 0.1,
        color: RFXColors.lightOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: RFXSpacing.spacing6,
            vertical: RFXSpacing.spacing6,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(RFXSpacing.spacing6),
                child: Image.asset(
                  event['imgPath']!,
                  width: RFXSpacing.spacing52,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: RFXSpacing.spacing8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event['title'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: RFXColors.lightPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    event['description'],
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
