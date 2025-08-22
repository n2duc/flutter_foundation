class ExploreRepositories {
  ExploreRepositories();

  /// Test place data
  Future<List<Map<String, dynamic>>> getPlaceList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    const imagePath = 'assets/images/hanoi.jpg';
    return Future.value([
      {
        "id": 1,
        "title": "Quang Truong Ba Dinh",
        "location": "Ha Noi",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
      {
        "id": 2,
        "title": "Ben Thanh Market",
        "location": "Ho Chi Minh City",
        "imgPath": imagePath,
        'tour_amount': 120,
      },
      {
        "id": 3,
        "title": "Dragon Bridge",
        "location": "Da Nang City",
        "imgPath": imagePath,
        'tour_amount': 40,
      },
      {
        "id": 4,
        "title": "Cung Dinh Hue",
        "location": "Thua Thien Hue City",
        "imgPath": imagePath,
        'tour_amount': 80,
      },
      {
        "id": 5,
        "title": "Vinpearl Beach",
        "location": "Khanh Hoa Province",
        "imgPath": imagePath,
        'tour_amount': 60,
      },
      {
        "id": 6,
        "title": "Ha Long Bay",
        "location": "Quang Ninh Province",
        "imgPath": imagePath,
        'tour_amount': 200,
      },
      {
        "id": 7,
        "title": "Sapa",
        "location": "Lao Cai Province",
        "imgPath": imagePath,
        'tour_amount': 150,
      },
      {
        "id": 8,
        "title": "Hoi An Ancient Town",
        "location": "Quang Nam Province",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
      {
        "id": 9,
        "title": "Nha Trang",
        "location": "Khanh Hoa Province",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
      {
        "id": 10,
        "title": "Phong Nha-Ke Bang National Park",
        "location": "Quang Binh Province",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
      {
        "id": 11,
        "title": "Mui Ne",
        "location": "Binh Thuan Province",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
      {
        "id": 12,
        "title": "Hue Imperial Citadel",
        "location": "Thua Thien Hue Province",
        "imgPath": imagePath,
        'tour_amount': 100,
      },
    ]);
  }
}
