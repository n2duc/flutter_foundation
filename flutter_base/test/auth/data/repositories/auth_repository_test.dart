import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_base/auth/data/repositories/auth_repository.dart';

@GenerateMocks([FlutterAppAuth, FlutterSecureStorage])
import 'auth_repository_test.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockFlutterAppAuth mockAppAuth;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockAppAuth = MockFlutterAppAuth();
    mockSecureStorage = MockFlutterSecureStorage();
    authRepository = AuthRepository(
      appAuth: mockAppAuth,
      secureStorage: mockSecureStorage,
    );
  });

  group('AuthRepository', () {
    test('login success saves tokens', () async {
      when(mockAppAuth.authorizeAndExchangeCode(any)).thenAnswer(
        (_) async => AuthorizationTokenResponse(
          'access_token',
          'refresh_token',
          DateTime.now().add(const Duration(hours: 1)),
          'id_token',
          'token_type',
          null,
          null,
          null,
        ),
      );

      when(
        mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')),
      ).thenAnswer((_) async => null);

      await authRepository.login();

      verify(
        mockSecureStorage.write(key: 'access_token', value: 'access_token'),
      ).called(1);
      verify(
        mockSecureStorage.write(key: 'refresh_token', value: 'refresh_token'),
      ).called(1);
      verify(
        mockSecureStorage.write(key: 'id_token', value: 'id_token'),
      ).called(1);
    });

    test('logout clears tokens', () async {
      when(
        mockSecureStorage.read(key: 'id_token'),
      ).thenAnswer((_) async => 'id_token');
      when(
        mockAppAuth.endSession(any),
      ).thenAnswer((_) async => EndSessionResponse(null));
      when(
        mockSecureStorage.delete(key: anyNamed('key')),
      ).thenAnswer((_) async => null);

      await authRepository.logout();

      verify(mockAppAuth.endSession(any)).called(1);
      verify(mockSecureStorage.delete(key: 'access_token')).called(1);
      verify(mockSecureStorage.delete(key: 'refresh_token')).called(1);
      verify(mockSecureStorage.delete(key: 'id_token')).called(1);
    });

    test('isLoggedIn returns true when token exists', () async {
      when(
        mockSecureStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => 'access_token');

      final result = await authRepository.isLoggedIn();

      expect(result, true);
    });

    test('isLoggedIn returns false when token is null', () async {
      when(
        mockSecureStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => null);

      final result = await authRepository.isLoggedIn();

      expect(result, false);
    });
  });
}
