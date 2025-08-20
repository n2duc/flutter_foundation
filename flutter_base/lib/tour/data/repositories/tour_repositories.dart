class TourRepository {
  TourRepository();

  ///Test data tour
  Future<List<Map<String, dynamic>>> getEventTour() async {
    await Future.delayed(const Duration(milliseconds: 300));
    const imagePath = 'assets/images/hanoi.jpg';
    return Future.value([
      {
        "id": 1,
        "title": "Cultural Festival",
        "description": "Cultural Festival",
        "imgPath": imagePath,
      },
      {
        "id": 2,
        "title": "Food Festival",
        "description": "Food Festival",
        "imgPath": imagePath,
      },
      {
        "id": 3,
        "title": "Music Festival",
        "description": "Music Festival",
        "imgPath": imagePath,
      },
      {
        "id": 4,
        "title": "Art Exhibition",
        "description": "Art Exhibition",
        "imgPath": imagePath,
      },
      {
        "id": 5,
        "title": "Historical Tour",
        "description": "Historical Tour",
        "imgPath": imagePath,
      },
      {
        "id": 6,
        "title": "Adventure Tour",
        "description": "Adventure Tour",
        "imgPath": imagePath,
      },
      {
        "id": 7,
        "title": "Nature Tour",
        "description": "Nature Tour",
        "imgPath": imagePath,
      },
      {
        "id": 8,
        "title": "Wildlife Tour",
        "description": "Wildlife Tour",
        "imgPath": imagePath,
      },
    ]);
  }

  Future<List<Map<String, dynamic>>> getTourList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Future.value([
      {
        "id": 1,
        "title": 'Ha Long Bay Cruise',
        "description":
            'A beautiful cruise through the limestone islands of Ha Long Bay. Experience the stunning natural beauty and cultural heritage of Vietnam.',
        "location": 'Quang Ninh',
        "price": 150000,
        "rating": 4.5,
        "imgPath": 'assets/images/hoian.jpg',
      },
      {
        "id": 2,
        "title": 'Sapa Mountain Trek',
        "description":
            'Enjoy breathtaking views and cultural experiences with ethnic minorities.',
        "location": 'Lao Cai, Vietnam',
        "price": 1200000,
        "rating": 4.7,
        "imgPath": 'assets/images/hoian.jpg',
      },
      {
        "id": 3,
        "title": 'Hoi An Ancient Town Tour',
        "description":
            'Discover the charm of the UNESCO World Heritage town of Hoi An.',
        "location": 'Quang Nam, Vietnam',
        "price": 800000,
        "rating": 4.9,
        "imgPath": 'assets/images/hoian.jpg',
      },
      {
        "id": 4,
        "title": 'Phong Nha Cave Tour',
        "description":
            'Explore the stunning caves and grottoes of Phong Nha-Ke Bang National Park.',
        "location": 'Quang Binh, Vietnam',
        "price": 900000,
        "rating": 3.0,
        "imgPath": 'assets/images/hoian.jpg',
      },
    ]);
  }
}
