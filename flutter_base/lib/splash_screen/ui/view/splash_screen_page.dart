import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/auth/auth.dart';
import 'package:flutter_base/splash_screen/ui/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  static const routeName = 'splash';

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _bloc = getIt<SplashCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<SplashCubit, SplashState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SplashStateLoaded) {
          context.goNamed(LoginPage.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        backgroundColor: RFXColors.lightPrimary,
        body: Padding(
          padding: const EdgeInsets.all(RFXSpacing.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RFX Flutter Foundation",
                style: textTheme.displayMedium?.copyWith(
                  color: RFXColors.lightOnPrimary,
                ),
              ),
              const SizedBox(height: RFXSpacing.spacing20),
              Text(
                'This is a sample splash screen page.',
                style: textTheme.bodyLarge?.copyWith(
                  color: RFXColors.lightOnPrimary,
                ),
              ),
              Lottie.asset(
                'assets/animations/loader_cat.json',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
