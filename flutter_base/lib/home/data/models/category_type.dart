import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

enum CategoryType { airplane, bus, car, truck, dribbble, shipping }

extension CategoryTypeExtension on CategoryType {
  String getName() {
    switch (this) {
      case CategoryType.airplane:
        return 'Airplane';
      case CategoryType.bus:
        return 'Bus';
      case CategoryType.car:
        return 'Car';
      case CategoryType.truck:
        return 'Truck';
      case CategoryType.dribbble:
        return 'Dribbble';
      case CategoryType.shipping:
        return 'Shipping';
    }
  }

  IconData getIcon() {
    switch (this) {
      case CategoryType.airplane:
        return Iconsax.airplane;
      case CategoryType.bus:
        return Iconsax.bus;
      case CategoryType.car:
        return Iconsax.car;
      case CategoryType.truck:
        return Iconsax.truck;
      case CategoryType.dribbble:
        return Iconsax.dribbble;
      case CategoryType.shipping:
        return Iconsax.truck_fast;
    }
  }
}
