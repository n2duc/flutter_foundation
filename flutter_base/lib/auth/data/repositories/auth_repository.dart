import 'dart:io';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final FlutterAppAuth _appAuth;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({FlutterAppAuth? appAuth, FlutterSecureStorage? secureStorage})
    : _appAuth = appAuth ?? const FlutterAppAuth(),
      _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final String _clientId = 'id.ncs-develop.com';
  final String _redirectUrl = 'com.example.rfx-flutter://login-callback';

  // Use 10.0.2.2 for Android emulator to access host localhost
  String get _issuer {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/realms/ncs-develop';
    }
    return 'http://localhost:8080/realms/ncs-develop';
  }

  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? result = await _appAuth
          .authorizeAndExchangeCode(
            AuthorizationTokenRequest(
              _clientId,
              _redirectUrl,
              issuer: _issuer,
              scopes: ['openid', 'profile', 'email', 'offline_access'],
              promptValues: ['login'],
            ),
          );

      if (result != null) {
        await _saveTokens(result);
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<void> logout() async {
    try {
      final idToken = await _secureStorage.read(key: 'id_token');
      if (idToken != null) {
        await _appAuth.endSession(
          EndSessionRequest(
            idTokenHint: idToken,
            postLogoutRedirectUrl: _redirectUrl,
            issuer: _issuer,
          ),
        );
      }
      await _clearTokens();
    } catch (e) {
      // Even if remote logout fails, clear local tokens
      await _clearTokens();
      throw Exception("Logout failed: $e");
    }
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<String?> getIdToken() async {
    return await _secureStorage.read(key: 'id_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  Future<void> _saveTokens(TokenResponse result) async {
    await _secureStorage.write(key: 'access_token', value: result.accessToken);
    await _secureStorage.write(
      key: 'refresh_token',
      value: result.refreshToken,
    );
    await _secureStorage.write(key: 'id_token', value: result.idToken);
  }

  Future<void> _clearTokens() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
    await _secureStorage.delete(key: 'id_token');
  }
}
