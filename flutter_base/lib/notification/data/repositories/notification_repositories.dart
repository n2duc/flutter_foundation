class NotificationRepositories {
  NotificationRepositories();

  Future<List<Map<String, dynamic>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return Future.value([
      {
        'id': 1,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        'id': 2,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
      },
      {
        'id': 3,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      },
      {
        'id': 4,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 20)),
      },
      {
        'id': 5,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 25)),
      },
      {
        'id': 6,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      },
      {
        'id': 7,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 35)),
      },
      {
        'id': 8,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 40)),
      },
      {
        'id': 9,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 45)),
      },
      {
        'id': 10,
        'content':
            'Component asset rectangle hand export. Horizontal flows duplicate mask select.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 50)),
      },
    ]);
  }

  Future<List<Map<String, dynamic>>> getActivities() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return Future.value([
      {
        'id': 1,
        'content':
            'John Doe just commented on your post "You should go to workshop to improve your skills." ',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        'id': 2,
        'content': 'Jane Smith just liked your post "Flutter is amazing!"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
      },
      {
        'id': 3,
        'content': 'Alice Johnson just shared your post "Top 10 Flutter Tips"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      },
      {
        'id': 4,
        'content':
            'Bob Brown just mentioned you in a comment "Great job on the Flutter project!"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 20)),
      },
      {
        'id': 5,
        'content': 'Charlie Davis just followed you.',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 25)),
      },
      {
        'id': 6,
        'content':
            'David Wilson just reacted to your post "Flutter vs React Native"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      },
      {
        'id': 7,
        'content':
            'Emily Clark just commented on your post "Learning Flutter step by step."',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 35)),
      },
      {
        'id': 8,
        'content': 'Frank Miller just liked your post "Flutter is awesome!"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 40)),
      },
      {
        'id': 9,
        'content': 'Grace Lee just shared your post "Top 10 Flutter Packages"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 45)),
      },
      {
        'id': 10,
        'content':
            'Henry Wilson just mentioned you in a comment "Great job on the Flutter project!"',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 50)),
      },
    ]);
  }
}
