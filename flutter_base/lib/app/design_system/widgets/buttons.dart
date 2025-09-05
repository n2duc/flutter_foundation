import 'package:flutter/material.dart';

const largeButtonHeight = 54.0;
const smallButtonHeight = 44.0;

class RFXPrimaryButton extends StatelessWidget {
  const RFXPrimaryButton.large({
    required this.title,
    required this.onPressed,
    this.disabled,
    super.key,
  }) : _height = largeButtonHeight;

  const RFXPrimaryButton.small({
    required this.title,
    required this.onPressed,
    this.disabled,
    super.key,
  }) : _height = smallButtonHeight;

  final String title;
  final double _height;
  final VoidCallback? onPressed;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButtonTheme(
      data: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          fixedSize: Size.fromHeight(_height),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: FilledButton(
        onPressed: disabled == true ? null : onPressed,
        child: Text(title),
      ),
    );
  }
}

class RFXTextButton extends StatelessWidget {
  const RFXTextButton({
    required this.title,
    required this.onPressed,
    this.disabled,
    super.key,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled == true ? null : onPressed,
      child: Text(title),
    );
  }
}

class RFXOutlinedButton extends StatelessWidget {
  const RFXOutlinedButton.large({
    required this.onPressed,
    required this.title,
    this.disabled,
    super.key,
  }) : _height = largeButtonHeight;

  const RFXOutlinedButton.small({
    required this.onPressed,
    required this.title,
    this.disabled,
    super.key,
  }) : _height = smallButtonHeight;

  final String title;
  final double _height;
  final VoidCallback? onPressed;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: disabled == true ? null : onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.colorScheme.primary),
        fixedSize: Size.fromHeight(_height),
      ),
      child: Text(title),
    );
  }
}
