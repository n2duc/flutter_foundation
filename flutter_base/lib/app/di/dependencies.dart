import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/splash_screen/ui/cubit/splash_cubit.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ProductionServiceLocator {
  AppConstants get appConstants => AppConstants();

  @mustCallSuper
  Future<void> setup() async {
    getIt
      ..registerFactory(() => SplashCubit())
      ..registerFactory(() => TourCubit(tourRepository: TourRepository()));
  }
}

class DevelopmentServiceLocator extends ProductionServiceLocator {
  @override
  AppConstants get appConstants => DevelopmentAppConstants();
}
