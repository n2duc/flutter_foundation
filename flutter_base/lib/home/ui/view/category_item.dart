import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/home/home.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryType item;
  final bool isSelected;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final itemIcon = item.getIcon();
    final itemName = item.getName();
    return RFXCard.greyBorder(
      child: InkWell(
        onTap: onTap,
        splashColor: RFXColors.lightOnSecondary.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? RFXColors.lightPrimary
                : RFXColors.lightOnPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(RFXSpacing.medium),
          ),
          padding: const EdgeInsets.all(RFXSpacing.spacing12),
          child: Row(
            children: [
              Icon(
                itemIcon,
                color: isSelected
                    ? RFXColors.lightOnPrimary
                    : RFXColors.lightPrimary,
                size: RFXSpacing.spacing18,
              ),
              const SizedBox(width: RFXSpacing.spacing8),
              Text(
                itemName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? RFXColors.lightOnPrimary
                      : RFXColors.lightPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
