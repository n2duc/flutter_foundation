import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_data.freezed.dart';
part 'tour_data.g.dart';

@freezed
abstract class TourData with _$TourData {
  const factory TourData({
    required int id,
    required String title,
    required String description,
    required String location,
    required int price,
    required double rating,
    String? imgPath,
  }) = _TourData;

  const TourData._();

  factory TourData.fromJson(Map<String, dynamic> json) =>
      _$TourDataFromJson(json);
}
