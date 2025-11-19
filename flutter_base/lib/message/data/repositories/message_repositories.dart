class MessageRepositories {
  MessageRepositories();

  Future<Map<String, dynamic>> getConversation() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();

    return {
      'id': 'conversation-1',
      'contact': {
        'name': 'Jane Doe',
        'avatarUrl':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=500&q=60',
        'location': 'Ha Noi, Viet Nam',
        'isOnline': true,
        'lastSeen': now.subtract(const Duration(minutes: 2)),
      },
      'messages': [
        {
          'id': 'message-1',
          'text': 'Hey there! Are you all set for the trip next weekend?',
          'isMine': false,
          'timestamp': now.subtract(const Duration(minutes: 42)),
          'status': 'read',
          'type': 'text',
        },
        {
          'id': 'message-2',
          'text':
              'Absolutely! I have booked the hotel and the guided tour already.',
          'isMine': true,
          'timestamp': now.subtract(const Duration(minutes: 39)),
          'status': 'read',
          'type': 'text',
        },
        {
          'id': 'message-3',
          'text': 'That is perfect. Did you add the sunrise boat ride as well?',
          'isMine': false,
          'timestamp': now.subtract(const Duration(minutes: 33)),
          'status': 'read',
          'type': 'text',
        },
        {
          'id': 'message-4',
          'text': 'Not yet, but it is on my list. I will add it tonight.',
          'isMine': true,
          'timestamp': now.subtract(const Duration(minutes: 27)),
          'status': 'read',
          'type': 'text',
        },
        {
          'id': 'message-5',
          'text':
              'Awesome! I found a great spot for lunch on day two. Sending the link now.',
          'isMine': false,
          'timestamp': now.subtract(const Duration(minutes: 18)),
          'status': 'delivered',
          'type': 'text',
        },
        {
          'id': 'message-6',
          'text': 'Looks delicious! Let us lock it in.',
          'isMine': true,
          'timestamp': now.subtract(const Duration(minutes: 14)),
          'status': 'sent',
          'type': 'text',
        },
        {
          'id': 'message-7',
          'text': 'Perfect. This trip is going to be amazing.',
          'isMine': false,
          'timestamp': now.subtract(const Duration(minutes: 8)),
          'status': 'sent',
          'type': 'text',
        },
      ],
    };
  }
}
