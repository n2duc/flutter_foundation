import 'package:flutter/material.dart';

class ZoomImageDialog extends StatelessWidget {
  const ZoomImageDialog({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: InteractiveViewer(child: Image.asset(imageUrl)),
      ),
    );
  }
}
