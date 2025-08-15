import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:flutter_base/splash_screen/splash_screen.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ProductionServiceLocator {
  AppConstants get appConstants => AppConstants();

  @mustCallSuper
  Future<void> setup() async {
    getIt
      ..registerFactory(() => SplashCubit())
      ..registerLazySingleton(TourRepository.new)
      ..registerFactory(() => TourCubit(tourRepository: getIt()))
      ..registerLazySingleton(ExploreRepositories.new)
      ..registerFactory(() => ExploreCubit(exploreRepositories: getIt()));
  }
}

class DevelopmentServiceLocator extends ProductionServiceLocator {
  @override
  AppConstants get appConstants => DevelopmentAppConstants();
}
