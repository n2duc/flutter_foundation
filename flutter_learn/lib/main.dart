import 'package:flutter/material.dart';
import 'package:flutter_learn/models/shop.dart';
import 'package:flutter_learn/pages/cart_page.dart';
import 'package:flutter_learn/pages/home_page.dart';
import 'package:flutter_learn/pages/intro_page.dart';
import 'package:flutter_learn/pages/menu_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => Shop(), child: const MyApp()),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/${IntroPage.routeName}',
  routes: [
    GoRoute(
      path: '/${HomePage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/${IntroPage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return const IntroPage();
      },
    ),
    GoRoute(
      path: '/${MenuPage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return const MenuPage();
      },
    ),
    GoRoute(
      path: '/${CartPage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return const CartPage();
      },
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
