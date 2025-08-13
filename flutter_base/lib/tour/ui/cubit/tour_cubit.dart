import 'package:bloc/bloc.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'tour_cubit.freezed.dart';

class TourCubit extends Cubit<TourState> {
  TourCubit({required this.tourRepository}) : super(const TourState.loading());

  static final log = Logger('TourCubit');

  @visibleForTesting
  final TourRepository tourRepository;

  Future<void> load() async {
    try {
      emit(const TourState.loading());
      final tours = await tourRepository.getTourList();
      emit(TourState.success(tours: tours));
    } catch (error, stackTrace) {
      log.severe('Error while trying to load TourCubit', error, stackTrace);
      emit(const TourState.error());
    }
  }
}

@freezed
sealed class TourState with _$TourState {
  const factory TourState.loading() = TourStateLoading;

  const factory TourState.success({required List<TourData> tours}) =
      TourStateSuccess;

  const factory TourState.error() = TourStateError;
}
