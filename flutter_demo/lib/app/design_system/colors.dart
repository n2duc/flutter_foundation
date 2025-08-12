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
}
