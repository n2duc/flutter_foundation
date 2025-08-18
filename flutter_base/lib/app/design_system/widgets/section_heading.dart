import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: RFXSpacing.spacing16,
        vertical: RFXSpacing.spacing8,
      ),
      child: Row(
        children: [
          Icon(icon, color: RFXColors.lightPrimary, size: RFXSpacing.spacing18),
          const SizedBox(width: RFXSpacing.spacing6),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
