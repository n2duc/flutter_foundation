import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: RFXSpacing.spacing12,
        left: RFXSpacing.spacing12,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: RFXColors.lightPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
