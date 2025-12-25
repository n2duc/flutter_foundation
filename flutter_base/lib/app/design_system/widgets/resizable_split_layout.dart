import 'package:flutter/material.dart';

class ResizableSplitLayout extends StatefulWidget {
  const ResizableSplitLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.initialLeftWidth = 300.0,
    this.minRightWidth,
    this.maxRightWidth,
  });

  final Widget leftChild;
  final Widget rightChild;
  final double initialLeftWidth;
  final double? minRightWidth;
  final double? maxRightWidth;

  @override
  State<ResizableSplitLayout> createState() => _ResizableSplitLayoutState();
}

class _ResizableSplitLayoutState extends State<ResizableSplitLayout> {
  late double _leftWidth;

  @override
  void initState() {
    super.initState();
    _leftWidth = widget.initialLeftWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // Calculate min and max left width based on right width constraints
        // If maxRightWidth is set, left width cannot be smaller than (total - maxRight)
        final minLeft = widget.maxRightWidth != null
            ? (maxWidth - widget.maxRightWidth!).clamp(100.0, maxWidth - 100.0)
            : 100.0;

        // If minRightWidth is set, left width cannot be larger than (total - minRight)
        final maxLeft = widget.minRightWidth != null
            ? (maxWidth - widget.minRightWidth!).clamp(100.0, maxWidth - 100.0)
            : maxWidth - 100.0;

        return Row(
          children: [
            SizedBox(
              width: _leftWidth.clamp(minLeft, maxLeft),
              child: widget.leftChild,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _leftWidth = (_leftWidth + details.delta.dx).clamp(
                      minLeft,
                      maxLeft,
                    );
                  });
                },
                child: Container(
                  width: 8,
                  color: Colors.grey.withValues(alpha: 0.2),
                  child: const Center(
                    child: VerticalDivider(thickness: 1, width: 1),
                  ),
                ),
              ),
            ),
            Expanded(child: widget.rightChild),
          ],
        );
      },
    );
  }
}
