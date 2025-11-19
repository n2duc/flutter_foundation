import 'package:dio/dio.dart';
import 'package:flutter_base/app/app.dart';
import 'package:logging/logging.dart';

class RefreshTokenUseCase {
  RefreshTokenUseCase({
    required this.localStorageDataSource,
    required this.appConstants,
  });

  static final log = Logger('RefreshTokenService');

  final LocalStorageDataSource localStorageDataSource;
  final AppConstants appConstants;

  Future<Response<dynamic>> call(RequestOptions requestOptions) async =>
      _refreshToken(requestOptions);

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final token = await localStorageDataSource.read(StorageKey.refreshToken);
    final deviceId = await DeviceInfoHelpers.getDeviceId();

    requestOptions.headers['Authorization'] = 'JWT $token';
    requestOptions.headers['Content-Type'] = 'application/json';
    requestOptions.headers['accept'] = '*/*';
    requestOptions.headers['x-device'] = deviceId;

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final dioOptions = BaseOptions(
      baseUrl: appConstants.baseUrl,
      connectTimeout: appConstants.connectTimeout,
      receiveTimeout: appConstants.responseTimeOut,
    );

    final dio = Dio(dioOptions);

    try {
      final response = await dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
      return response;
    } on Exception catch (e) {
      log.warning(e);
      throw Exception('Unable to retry fetch');
    }
  }

  Future<void> _fetchNewToken() async {
    try {
      //final response = await refreshTokenRepository.fetchNewToken();
      // if (response != null && response.success) {
      //   await localStorageDataSource.write(key: StorageKey.accessToken, value: response.accessToken);
      //   await localStorageDataSource.read(response.refreshToken);
      // } else {
      //   throw Exception('Token Expired. Please log in again.');
      // }
      // TODO(init): Write code to fetch new token
      throw Exception('Token Expired. Please log in again.');
    } catch (e) {
      log.warning('Unable to fetch new token', e);
      throw Exception('Unable to fetch new token');
    }
  }

  Future<Response<dynamic>> _refreshToken(RequestOptions requestOptions) async {
    await _fetchNewToken();
    final request = await _retryRequest(requestOptions);
    return request;
  }
}
