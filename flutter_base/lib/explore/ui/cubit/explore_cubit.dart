import 'package:bloc/bloc.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'explore_cubit.freezed.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({required this.exploreRepositories})
    : super(const ExploreState.loading());

  static final log = Logger('ExploreCubit');

  @visibleForTesting
  final ExploreRepositories exploreRepositories;

  Future<void> load() async {
    try {
      final places = await exploreRepositories.getPlaceList();
      emit(ExploreState.success(listPlace: places));
    } catch (error, stackTrace) {
      log.severe('Error while trying to load ExploreCubit', error, stackTrace);
      emit(
        ExploreState.error(
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }
}

@freezed
sealed class ExploreState with _$ExploreState {
  const factory ExploreState.loading() = ExploreStateLoading;
  const factory ExploreState.success({
    required List<Map<String, dynamic>> listPlace,
  }) = ExploreStateSuccess;
  const factory ExploreState.error({required String errorMessage}) =
      ExploreStateError;
}
