import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/app/authorization/authorization_interceptor.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_base/example/example.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:flutter_base/message/message.dart';
import 'package:flutter_base/notification/notification.dart';
import 'package:flutter_base/splash_screen/splash_screen.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ProductionServiceLocator {
  AppConstants get appConstants => AppConstants();

  @mustCallSuper
  Future<void> setup() async {
    final sharedPreferences = SharedPreferencesAsync();
    getIt.registerSingleton(sharedPreferences);

    final localStorageDataSource = LocalStorageDataSource(
      sharedPreferences: getIt(),
    );
    await localStorageDataSource.init();

    getIt
      ..registerSingleton(localStorageDataSource)
      ..registerLazySingleton(
        () => AuthorizationInterceptor(
          appConstants: appConstants,
          localStorageDataSource: localStorageDataSource,
        ),
      )
      ..registerLazySingleton(() => createDio(getIt()))
      ..registerLazySingleton(TourRepository.new)
      ..registerLazySingleton(ExploreRepositories.new)
      ..registerLazySingleton(NotificationRepositories.new)
      ..registerLazySingleton(MessageRepositories.new)
      ..registerLazySingleton(ExampleRepositories.new)
      ..registerLazySingleton<CartCubit>(() => CartCubit())
      ..registerFactory(() => SplashCubit())
      ..registerFactory(() => TourCubit(tourRepository: getIt()))
      ..registerFactory(() => ExploreCubit(exploreRepositories: getIt()))
      ..registerFactory(
        () => NotificationCubit(notificationRepositories: getIt()),
      )
      ..registerFactory(() => MessageCubit(messageRepositories: getIt()))
      ..registerFactory(() => ExampleCubit(exampleRepositories: getIt()))
      ..registerFactory(() => ProductDetailCubit(exampleRepositories: getIt()));
  }

  Dio createDio(AuthorizationInterceptor authorization) {
    final options = BaseOptions(
      baseUrl: appConstants.baseUrl,
      connectTimeout: appConstants.connectTimeout,
      receiveTimeout: appConstants.responseTimeOut,
    );

    final dio = Dio(options);
    dio.interceptors.add(authorization);

    return dio;
  }
}

class StagingServiceLocator extends ProductionServiceLocator {
  @override
  AppConstants get appConstants => StaggingAppConstants();
}

class DevelopmentServiceLocator extends ProductionServiceLocator {
  @override
  AppConstants get appConstants => DevelopmentAppConstants();
}
