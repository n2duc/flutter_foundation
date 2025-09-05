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
        "imgPath": 'assets/images/halong.jpg',
      },
      {
        "id": 2,
        "title": 'Sapa Mountain Trek',
        "description":
            'Enjoy breathtaking views and cultural experiences with ethnic minorities.',
        "location": 'Lao Cai, Vietnam',
        "price": 1200000,
        "rating": 4.7,
        "imgPath": 'assets/images/hagiang.jpg',
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
        "imgPath": 'assets/images/saigon.jpg',
      },
      {
        "id": 5,
        "title": 'Thanh dia My Son',
        "description":
            'Explore the stunning temples and ruins of My Son Sanctuary.',
        "location": 'Quang Nam, Vietnam',
        "price": 129000,
        "rating": 5.0,
        "imgPath": 'assets/images/quangnam.jpg',
      },
    ]);
  }

  Future<List<Map<String, dynamic>>> getTourByDestination() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Future.value([
      {
        "id": 101,
        "title": "Mekong Delta Discovery",
        "description":
            "Journey through the lush waterways and floating markets of the Mekong Delta.",
        "location": "Can Tho, Vietnam",
        "price": 950000,
        "rating": 4.6,
        "imgPath": "assets/images/hagiang.jpg",
      },
      {
        "id": 102,
        "title": "Da Lat Flower Gardens",
        "description":
            "Explore the vibrant flower gardens and cool climate of Da Lat.",
        "location": "Da Lat, Vietnam",
        "price": 700000,
        "rating": 4.4,
        "imgPath": "assets/images/halong.jpg",
      },
      {
        "id": 103,
        "title": "Hue Imperial City Tour",
        "description":
            "Step back in time with a guided tour of the ancient citadel and royal tombs.",
        "location": "Hue, Vietnam",
        "price": 850000,
        "rating": 4.8,
        "imgPath": "assets/images/hoian.jpg",
      },
      {
        "id": 104,
        "title": "Nha Trang Beach Escape",
        "description":
            "Relax on the sandy beaches and enjoy water sports in Nha Trang.",
        "location": "Nha Trang, Vietnam",
        "price": 600000,
        "rating": 4.3,
        "imgPath": "assets/images/hanoi.jpg",
      },
      {
        "id": 105,
        "title": "Ban Gioc Waterfall Adventure",
        "description":
            "Marvel at the majestic Ban Gioc Waterfall on the border with China.",
        "location": "Cao Bang, Vietnam",
        "price": 1100000,
        "rating": 4.7,
        "imgPath": "assets/images/ninhbinh.jpg",
      },
      {
        "id": 106,
        "title": "Con Dao Island Retreat",
        "description":
            "Unwind on pristine beaches and explore the history of Con Dao Island.",
        "location": "Con Dao, Vietnam",
        "price": 1300000,
        "rating": 4.9,
        "imgPath": "assets/images/quangnam.jpg",
      },
      {
        "id": 107,
        "title": "Ba Be Lake Exploration",
        "description":
            "Discover the tranquil beauty and ethnic villages around Ba Be Lake.",
        "location": "Bac Kan, Vietnam",
        "price": 750000,
        "rating": 4.2,
        "imgPath": "assets/images/saigon.jpg",
      },
      {
        "id": 108,
        "title": "Cat Ba Island Adventure",
        "description":
            "Experience kayaking, hiking, and wildlife on Cat Ba Island.",
        "location": "Hai Phong, Vietnam",
        "price": 980000,
        "rating": 4.5,
        "imgPath": "assets/images/tau.jpg",
      },
      {
        "id": 109,
        "title": "Mui Ne Sand Dunes Tour",
        "description":
            "Enjoy the unique landscape and activities at the Mui Ne sand dunes.",
        "location": "Binh Thuan, Vietnam",
        "price": 650000,
        "rating": 4.1,
        "imgPath": "assets/images/hanoi.jpg",
      },
      {
        "id": 110,
        "title": "Saigon City Highlights",
        "description":
            "Discover the vibrant culture, history, and cuisine of Ho Chi Minh City.",
        "location": "Ho Chi Minh City, Vietnam",
        "price": 500000,
        "rating": 4.6,
        "imgPath": "assets/images/hagiang.jpg",
      },
    ]);
  }
}
