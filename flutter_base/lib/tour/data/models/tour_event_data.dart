import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_event_data.freezed.dart';
part 'tour_event_data.g.dart';

@freezed
abstract class TourEventData with _$TourEventData {
  const factory TourEventData({
    required int id,
    required String title,
    required String description,
    String? imgPath,
  }) = _TourEventData;

  const TourEventData._();

  factory TourEventData.fromJson(Map<String, dynamic> json) =>
      _$TourEventDataFromJson(json);
}
