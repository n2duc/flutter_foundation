import 'package:flutter/material.dart';

class RFXColors {
  RFXColors._();
  static const int _primaryValue = 0xFF872D2D;
  static const int _secondaryValue = 0xFFFFF5F5;

  static const MaterialColor red = MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFFFF5F5),
    100: Color(0xFFFFE6E6),
    200: Color(0xFFFFD6D6),
    300: Color(0xFFFFBFBF),
    400: Color(0xFFFFA8A8),
    500: Color(_primaryValue),
    600: Color(0xFF872D2D),
    700: Color(0xFF7A2626),
    800: Color(0xFF6C1F1F),
    900: Color(0xFF5E1818),
  });

  static const MaterialColor secondary =
      MaterialColor(_secondaryValue, <int, Color>{
        50: Color(0xFFFFF5F5),
        100: Color(0xFFFFE6E6),
        200: Color(0xFFFFD6D6),
        300: Color(0xFFFFBFBF),
        400: Color(0xFFFFA8A8),
        500: Color(_secondaryValue),
        600: Color(0xFFFFF5F5),
        700: Color(0xFFFFF5F5),
        800: Color(0xFFFFF5F5),
        900: Color(0xFFFFF5F5),
      });

  static const Color darkPrimary = Color(0xFF872D2D);

  static const Color lightPrimary = Color(0xFF662C2C);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFCDEDA4);
  static const Color lightOnPrimaryContainer = Color(0xFF0F2000);
  static const Color lightPrimaryFixed = Color(0xFFCDEDA4);
  static const Color lightPrimaryFixedDim = Color(0xFFB1D18A);
  static const Color lightOnPrimaryFixed = Color(0xFF0F2000);
  static const Color lightOnPrimaryFixedVariant = Color(0xFF344E16);

  static const Color lightSurfaceDim = Color(0xFFDADBD0);
  static const Color lightSurface = Color(0xFFF9FAEF);
  static const Color lightSurfaceBright = Color(0xFFDADBD0);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF3F4E9);
  static const Color lightSurfaceContainer = Color(0xFFEEEFE4);
  static const Color lightSurfaceContainerHigh = Color(0xFFE8E9DE);
  static const Color lightSurfaceContainerHighest = Color(0xFFE2E3D8);
  static const Color lightOnSurface = Color(0xFF1A1C16);
  static const Color lightOnSurfaceVariant = Color(0xFF4A454E);
  static const Color lightOutline = Color(0xFF7B757F);
  static const Color lightOutlineVariant = Color(0xFFCCC4CF);

  static const Color lightSecondary = Color(0xFF8A5021);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightSecondaryContainer = Color(0xFFFFDCC5);
  static const Color lightOnSecondaryContainer = Color(0xFF301400);
  static const Color lightSecondaryFixed = Color(0xFFFFDCC5);
  static const Color lightSecondaryFixedDim = Color(0xFFFFB782);
  static const Color lightOnSecondaryFixed = Color(0xFF301400);
  static const Color lightOnSecondaryFixedVariant = Color(0xFF6D390A);

  static const Color lightTertiary = Color(0xFF505B92);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightTertiaryContainer = Color(0xFFDDE1FF);
  static const Color lightOnTertiaryContainer = Color(0xFF09164B);
  static const Color lightTertiaryFixed = Color(0xFFDDE1FF);
  static const Color lightTertiaryFixedDim = Color(0xFFB9C3FF);
  static const Color lightOnTertiaryFixed = Color(0xFF09164B);
  static const Color lightOnTertiaryFixedVariant = Color(0xFF384379);

  static const Color lightError = Color(0xFFBA1A1A);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);
  static const Color lightOnErrorContainer = Color(0xFF410002);

  static const Color lightInverseSurface = Color(0xFF2F312A);
  static const Color lightInverseOnSurface = Color(0xFFF0F2E6);
  static const Color lightInversePrimary = Color(0xFFB1D18A);
  static const Color lightScrim = Color(0xFF000000);
  static const Color lightShadow = Color(0xFF000000);
}
