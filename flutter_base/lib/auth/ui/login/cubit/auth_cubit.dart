import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/auth/data/repositories/auth_repository.dart';
import 'package:flutter_base/auth/ui/login/cubit/auth_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial());

  Future<void> checkLoginStatus() async {
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final idToken = await _authRepository.getIdToken();
        if (idToken != null) {
          final decodedToken = JwtDecoder.decode(idToken);
          final username =
              decodedToken['name'] ??
              decodedToken['preferred_username'] ??
              'User';
          emit(AuthAuthenticated(username));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login() async {
    try {
      await _authRepository.login();
      await checkLoginStatus();
    } catch (e) {
      // Handle error if needed, or let UI handle it via listener if we add error state
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }
}
