import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/cart/cart_bloc.dart';
import 'package:flutter_demo/models/food.dart';
import 'package:flutter_demo/pages/about_page.dart';
import 'package:flutter_demo/pages/cart_page.dart';
import 'package:flutter_demo/pages/food_detail_page.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/intro_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/${IntroPage.routeName}',
  routes: [
    GoRoute(
      path: '/${IntroPage.routeName}',
      builder: (context, state) => const IntroPage(),
    ),
    GoRoute(
      path: '/${AboutPage.routeName}',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/${HomePage.routeName}',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/${FoodDetailPage.routeName}',
      builder: (context, state) => FoodDetailPage(food: state.extra as Food),
    ),
    GoRoute(
      path: '/${CartPage.routeName}',
      builder: (context, state) => const CartPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
