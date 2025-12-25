// import 'package:bloc/bloc.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'tour_cubit.freezed.dart';

class TourCubit extends Cubit<TourState> {
  TourCubit({required this.tourRepository})
    : super(
        const TourState.idle(
          listEvent: [],
          listTour: [],
          listTourDestination: [],
        ),
      );

  static final log = Logger('TourCubit');

  @visibleForTesting
  final TourRepository tourRepository;

  Future<void> load() async {
    emit(
      TourState.loading(
        listEvent: state.listEvent,
        listTour: state.listTour,
        listTourDestination: state.listTourDestination,
      ),
    );
    try {
      final tours = await tourRepository.getTourList();
      emit(
        TourState.success(
          listTour: tours,
          listEvent: state.listEvent,
          listTourDestination: state.listTourDestination,
        ),
      );
    } catch (error, stackTrace) {
      log.severe('Error while trying to load TourCubit', error, stackTrace);
      emit(
        TourState.error(
          listTour: state.listTour,
          listEvent: state.listEvent,
          listTourDestination: state.listTourDestination,
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }

  Future<void> getEventList() async {
    emit(
      TourState.loading(
        listEvent: state.listEvent,
        listTour: state.listTour,
        listTourDestination: state.listTourDestination,
      ),
    );
    try {
      final event = await tourRepository.getEventTour();
      emit(
        TourState.success(
          listEvent: event,
          listTour: state.listTour,
          listTourDestination: state.listTourDestination,
        ),
      );
    } catch (error, stackTrace) {
      log.severe('Error while trying to load TourCubit', error, stackTrace);
      emit(
        TourState.error(
          listEvent: state.listEvent,
          listTour: state.listTour,
          listTourDestination: state.listTourDestination,
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }

  Future<void> getTourDestinationList() async {
    emit(
      TourState.loading(
        listEvent: state.listEvent,
        listTour: state.listTour,
        listTourDestination: state.listTourDestination,
      ),
    );
    try {
      final destination = await tourRepository.getTourByDestination();
      emit(
        TourState.success(
          listTourDestination: destination,
          listEvent: state.listEvent,
          listTour: state.listTour,
        ),
      );
    } catch (error, stackTrace) {
      log.severe('Error while trying to load TourCubit', error, stackTrace);
      emit(
        TourState.error(
          listTourDestination: state.listTourDestination,
          listEvent: state.listEvent,
          listTour: state.listTour,
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }
}

@freezed
sealed class TourState with _$TourState {
  const factory TourState.idle({
    @Default([]) List<Map<String, dynamic>> listTour,
    @Default([]) List<Map<String, dynamic>> listEvent,
    @Default([]) List<Map<String, dynamic>> listTourDestination,
  }) = AssetIdle;

  const factory TourState.loading({
    @Default([]) List<Map<String, dynamic>> listTour,
    @Default([]) List<Map<String, dynamic>> listEvent,
    @Default([]) List<Map<String, dynamic>> listTourDestination,
  }) = TourStateLoading;

  const factory TourState.success({
    @Default([]) List<Map<String, dynamic>> listTour,
    @Default([]) List<Map<String, dynamic>> listEvent,
    @Default([]) List<Map<String, dynamic>> listTourDestination,
  }) = TourStateSuccess;

  const factory TourState.error({
    @Default([]) List<Map<String, dynamic>> listTour,
    @Default([]) List<Map<String, dynamic>> listEvent,
    @Default([]) List<Map<String, dynamic>> listTourDestination,
    required String errorMessage,
  }) = TourStateError;
}
