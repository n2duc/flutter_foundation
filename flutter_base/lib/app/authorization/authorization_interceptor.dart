import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/auth/auth.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  AuthorizationInterceptor({
    required this.appConstants,
    required this.localStorageDataSource,
  });

  @visibleForTesting
  final AppConstants appConstants;

  @visibleForTesting
  final LocalStorageDataSource localStorageDataSource;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await localStorageDataSource.read(StorageKey.accessToken);
    final deviceId = await DeviceInfoHelpers.getDeviceId();

    if (token != null &&
        token.isNotEmpty &&
        options.headers['Authorization'] != null) {
      options.headers['Authorization'] = 'JWT $token';
    }
    if (options.contentType == null) {
      options.headers['Content-Type'] = 'application/json';
    }

    options.headers['accept'] = '*/*';
    options.headers['x-device'] = deviceId;
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      try {
        if (err.response?.statusCode == 403) {
          handler.next(err);
        } else {
          final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
          final data = await refreshTokenUseCase.call(err.requestOptions);
          return handler.resolve(data);
        }
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
