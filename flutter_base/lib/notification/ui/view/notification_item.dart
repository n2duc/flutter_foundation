import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final Map<String, dynamic> notification;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'yyyy-MM-dd – kk:mm',
    ).format(notification['timestamp']);

    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: RFXSpacing.spacing6,
        horizontal: RFXSpacing.spacing20,
      ),
      leading: Container(
        decoration: BoxDecoration(
          color: RFXColors.lightPrimary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(RFXSpacing.spacing8),
        child: Icon(
          Iconsax.message,
          color: RFXColors.lightPrimary,
          size: RFXSpacing.spacing20,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: RFXSpacing.small),
        child: Text(notification['content'], style: textTheme.titleSmall),
      ),
      subtitle: Text(formattedDate, style: textTheme.bodySmall),
      onTap: () {},
    );
  }
}
