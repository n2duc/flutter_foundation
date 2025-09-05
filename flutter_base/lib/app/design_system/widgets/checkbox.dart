import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class RFXCheckbox extends StatelessWidget {
  const RFXCheckbox({super.key, required this.value, this.onChanged});

  final bool value;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        width: RFXSpacing.spacing18,
        height: RFXSpacing.spacing18,
        decoration: BoxDecoration(
          color: value ? RFXColors.lightPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value ? RFXColors.lightPrimary : Colors.grey,
            width: 1,
          ),
        ),
        child: value
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
