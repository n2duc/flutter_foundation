import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/user/user.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.menu});

  final MenuType menu;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: RFXSpacing.spacing12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(RFXSpacing.spacing10),
            decoration: const BoxDecoration(
              color: RFXColors.lightPrimary,
              borderRadius: BorderRadius.all(
                Radius.circular(RFXSpacing.spacing12),
              ),
            ),
            child: Icon(
              menu.icon,
              color: Colors.white,
              size: RFXSpacing.spacing20,
            ),
          ),
          const SizedBox(width: RFXSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu.title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(menu.description, style: textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Iconsax.arrow_right_2, size: RFXSpacing.spacing16),
        ],
      ),
    );
  }
}
