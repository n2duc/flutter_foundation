import 'package:flutter_base/app/app.dart';

import 'package:flutter/material.dart';

final appTheme =
    ThemeData.from(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: RFXColors.lightPrimary,
        onPrimary: RFXColors.lightOnPrimary,
        secondary: RFXColors.lightSecondary,
        onSecondary: RFXColors.lightOnSecondary,
        surface: RFXColors.lightSurface,
        error: RFXColors.lightError,
        onSurface: RFXColors.lightOnSurface,
        onError: RFXColors.lightOnError,
      ),
      textTheme: rfxTextTheme,
    ).copyWith(
      highlightColor: RFXColors.lightPrimary.withValues(alpha: 0.2),
      splashColor: RFXColors.lightPrimary.withValues(alpha: 0.2),
      appBarTheme: const AppBarTheme(centerTitle: false),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: RFXColors.lightPrimary,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            );
          }
          return const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          if (states.contains(WidgetState.pressed)) {
            return const IconThemeData(color: Colors.red);
          }
          return const IconThemeData(color: Colors.white70);
        }),
      ),
    );
