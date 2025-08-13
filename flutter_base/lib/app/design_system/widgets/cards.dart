import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class RFXCard extends StatelessWidget {
  const RFXCard({
    required this.child,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.shadowColor,
    this.cornerRadius,
    super.key,
  });

  const RFXCard.greyBorder({
    required this.child,
    super.key,
    this.margin,
    Color? backgroundColor,
    this.cornerRadius,
  }) : backgroundColor = backgroundColor ?? Colors.white,
       borderColor = RFXColors.darkPrimary,
       elevation = 0,
       shadowColor = null;

  const RFXCard.greyBorderWithShadow({
    required this.child,
    super.key,
    this.margin,
    Color? backgroundColor,
    this.cornerRadius,
  }) : backgroundColor = backgroundColor ?? Colors.white,
       borderColor = RFXColors.darkPrimary,
       elevation = 8,
       shadowColor = const Color.fromRGBO(0, 0, 0, 0.3);

  final Widget child;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final Color? shadowColor;
  final double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 0,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadius ?? 24),
        side: borderColor == null
            ? BorderSide.none
            : BorderSide(color: borderColor!),
      ),
      clipBehavior: Clip.hardEdge,
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      surfaceTintColor: Colors.transparent,
      margin: margin ?? EdgeInsets.zero,
      child: child,
    );
  }
}
