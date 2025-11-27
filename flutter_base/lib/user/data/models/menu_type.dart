import 'package:flutter/material.dart';
import 'package:flutter_base/example/example.dart';
import 'package:flutter_base/user/user.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

enum MenuType { profile, payment, lang, privacy, setting }

extension MenuTypeExtension on MenuType {
  String get title {
    switch (this) {
      case MenuType.profile:
        return 'Profile';
      case MenuType.payment:
        return 'Payment';
      case MenuType.lang:
        return 'Language';
      case MenuType.privacy:
        return 'Privacy';
      case MenuType.setting:
        return 'Settings';
    }
  }

  String get description {
    switch (this) {
      case MenuType.profile:
        return 'View and edit profile';
      case MenuType.payment:
        return 'Payment methods';
      case MenuType.lang:
        return 'Language settings';
      case MenuType.privacy:
        return 'Privacy settings';
      case MenuType.setting:
        return 'App settings';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuType.profile:
        return Iconsax.personalcard;
      case MenuType.payment:
        return Iconsax.wallet;
      case MenuType.lang:
        return Iconsax.global;
      case MenuType.privacy:
        return Iconsax.lock;
      case MenuType.setting:
        return Iconsax.setting;
    }
  }

  String? get routeName {
    switch (this) {
      case MenuType.setting:
        return SettingsPage.routeName;
      case MenuType.privacy:
        return ExamplePage.routeName;
      default:
        return null;
    }
  }

  void navigate(BuildContext context) {
    final route = routeName;
    if (route != null) {
      context.pushNamed(route);
    }
  }
}
