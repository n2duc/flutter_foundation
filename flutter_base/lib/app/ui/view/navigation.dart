import 'package:flutter/material.dart';
import 'package:flutter_base/auth/auth.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_base/home/home.dart';
import 'package:flutter_base/splash_screen/splash_screen.dart';
import 'package:flutter_base/user/user.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavigationShellPage extends StatelessWidget {
  const BottomNavigationShellPage({super.key, required this.navigationShell});

  static const routeName = 'main';

  final StatefulNavigationShell navigationShell;

  void handleDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: handleDestinationSelected,
        selectedIndex: navigationShell.currentIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Iconsax.home_1),
            icon: Icon(Iconsax.home_copy),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Iconsax.user_octagon),
            icon: Icon(Iconsax.user_octagon_copy),
            label: 'Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Iconsax.monitor),
            icon: Icon(Iconsax.monitor_copy),
            label: 'Monitor',
          ),
        ],
      ),
    );
  }
}

final router = GoRouter(
  initialLocation: '/${SplashScreenPage.routeName}',
  routes: [
    GoRoute(
      name: SplashScreenPage.routeName,
      path: '/${SplashScreenPage.routeName}',
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      name: LoginPage.routeName,
      path: '/${LoginPage.routeName}',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: CartPage.routeName,
      path: '/${CartPage.routeName}',
      builder: (context, state) => const CartPage(),
    ),
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, routerState, navigationShell) {
        return CustomTransitionPage<void>(
          key: routerState.pageKey,
          child: BottomNavigationShellPage(navigationShell: navigationShell),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: HomePage.routeName,
              path: '/${HomePage.routeName}',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${UserPage.routeName}',
              builder: (context, state) => const UserPage(),
              name: UserPage.routeName,
            ),
          ],
        ),
      ],
    ),
  ],
);
