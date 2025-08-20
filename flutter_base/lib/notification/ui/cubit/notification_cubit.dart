import 'package:bloc/bloc.dart';
import 'package:flutter_base/notification/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepositories})
    : super(
        const NotificationState.idle(listNotification: [], listActivity: []),
      );

  static final log = Logger('NotificationCubit');

  @visibleForTesting
  final NotificationRepositories notificationRepositories;

  Future<void> loadNotifications() async {
    emit(
      NotificationState.loading(
        listNotification: state.listNotification,
        listActivity: state.listActivity,
      ),
    );
    try {
      final notifications = await notificationRepositories.getNotifications();
      emit(
        NotificationState.success(
          listNotification: notifications,
          listActivity: state.listActivity,
        ),
      );
    } catch (error, stackTrace) {
      log.severe(
        'Error while trying to load NotificationCubit',
        error,
        stackTrace,
      );
      emit(
        NotificationState.error(
          listNotification: state.listNotification,
          listActivity: state.listActivity,
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    } finally {
      emit(
        NotificationState.idle(
          listNotification: state.listNotification,
          listActivity: state.listActivity,
        ),
      );
    }
  }

  Future<void> loadActivities() async {
    emit(
      NotificationState.loading(
        listNotification: state.listNotification,
        listActivity: state.listActivity,
      ),
    );
    try {
      final activities = await notificationRepositories.getActivities();
      emit(
        NotificationState.success(
          listNotification: state.listNotification,
          listActivity: activities,
        ),
      );
    } catch (error, stackTrace) {
      log.severe(
        'Error while trying to load NotificationCubit',
        error,
        stackTrace,
      );
      emit(
        NotificationState.error(
          listNotification: state.listNotification,
          listActivity: state.listActivity,
          errorMessage:
              'Somthing went wrong. Please check your internet connection and try again.',
        ),
      );
    }
  }
}

@freezed
sealed class NotificationState with _$NotificationState {
  const factory NotificationState.idle({
    @Default([]) List<Map<String, dynamic>> listNotification,
    @Default([]) List<Map<String, dynamic>> listActivity,
  }) = NotificationStateIdle;
  const factory NotificationState.loading({
    @Default([]) List<Map<String, dynamic>> listNotification,
    @Default([]) List<Map<String, dynamic>> listActivity,
  }) = NotificationStateLoading;
  const factory NotificationState.success({
    @Default([]) List<Map<String, dynamic>> listNotification,
    @Default([]) List<Map<String, dynamic>> listActivity,
  }) = NotificationStateSuccess;
  const factory NotificationState.error({
    @Default([]) List<Map<String, dynamic>> listNotification,
    @Default([]) List<Map<String, dynamic>> listActivity,
    required String errorMessage,
  }) = NotificationStateError;
}
