import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(RFXSpacing.large),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
