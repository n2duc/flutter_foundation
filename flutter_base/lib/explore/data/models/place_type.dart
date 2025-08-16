import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

enum PlaceType { explore, sailing, kayaking, cottage }

extension PlaceTypeExtension on PlaceType {
  String getName() {
    switch (this) {
      case PlaceType.explore:
        return 'Explore';
      case PlaceType.sailing:
        return 'Sailing';
      case PlaceType.kayaking:
        return 'Kayaking';
      case PlaceType.cottage:
        return 'Cottage';
    }
  }

  IconData getIcon() {
    switch (this) {
      case PlaceType.explore:
        return Iconsax.discover;
      case PlaceType.sailing:
        return Iconsax.ship;
      case PlaceType.kayaking:
        return Iconsax.airplane;
      case PlaceType.cottage:
        return Iconsax.home_1;
    }
  }

  void navigate(BuildContext context) {
    switch (this) {
      case PlaceType.explore:
        //Next page explore
        break;
      case PlaceType.sailing:
        //Next page sailing
        break;
      case PlaceType.kayaking:
        //Next page kayaking
        break;
      case PlaceType.cottage:
        //Next page cottage
        break;
    }
  }
}
