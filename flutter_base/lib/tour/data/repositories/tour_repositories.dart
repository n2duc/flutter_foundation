import 'package:flutter_base/tour/tour.dart';
import 'package:meta/meta.dart';

class TourRepository {
  TourRepository();

  @visibleForTesting
  final List<TourData> tourList = [
    TourData(
      id: 1,
      title: 'Ha Long Bay Cruise',
      description:
          'A beautiful cruise through the limestone islands of Ha Long Bay.',
      location: 'Quang Ninh',
      price: 150000,
      rating: 4.5,
      imgPath: 'assets/images/hoian.jpg',
    ),
    TourData(
      id: 2,
      title: 'Sapa Mountain Trek',
      description:
          'Enjoy breathtaking views and cultural experiences with ethnic minorities.',
      location: 'Lao Cai, Vietnam',
      price: 1200000,
      rating: 4.7,
      imgPath: 'assets/images/hoian.jpg',
    ),
    TourData(
      id: 3,
      title: 'Hoi An Ancient Town Tour',
      description:
          'Discover the charm of the UNESCO World Heritage town of Hoi An.',
      location: 'Quang Nam, Vietnam',
      price: 800000,
      rating: 4.9,
      imgPath: 'assets/images/hoian.jpg',
    ),
  ];

  Future<List<TourData>> getTourList() async {
    await Future.delayed(const Duration(seconds: 500));
    return tourList;
  }
}
