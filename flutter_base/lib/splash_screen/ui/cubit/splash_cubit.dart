import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_cubit.freezed.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.loading() = SplashStateLoading;
  const factory SplashState.loaded() = SplashStateLoaded;
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.loading());

  static const _delayTime = Duration(seconds: 2);

  Future<void> load() async {
    await Future.delayed(_delayTime);
    emit(const SplashState.loaded());
  }
}
