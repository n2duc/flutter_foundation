import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryImage extends StatelessWidget {
  const GalleryImage({super.key, required this.imgPaths});

  final List<String> imgPaths;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: RFXSpacing.small,
      crossAxisSpacing: RFXSpacing.small,
      children: imgPaths.asMap().entries.map((entry) {
        int index = entry.key;
        String imgUrl = entry.value;

        int crossAxisCellCount = (index % 5 == 0 || index % 5 == 3) ? 2 : 1;
        int mainAxisCellCount = (index % 5 == 0 || index % 5 == 1) ? 2 : 1;

        return StaggeredGridTile.count(
          crossAxisCellCount: crossAxisCellCount,
          mainAxisCellCount: mainAxisCellCount,
          child: GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (_) => ZoomImageDialog(imageUrl: imgUrl),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(RFXSpacing.small),
              child: Image.asset(imgUrl, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    );
  }
}
