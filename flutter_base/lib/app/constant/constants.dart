class AppConstants {
  String get baseUrl => 'https://riverflow.solutions';

  Duration get connectTimeout => const Duration(seconds: 30);

  Duration get responseTimeOut => const Duration(seconds: 30);
}

// for stagging
class StaggingAppConstants extends AppConstants {
  @override
  String get baseUrl => 'https://stagging.riverflow.solutions';

  @override
  Duration get connectTimeout => const Duration(seconds: 5);

  @override
  Duration get responseTimeOut => const Duration(seconds: 5);
}

// for development
class DevelopmentAppConstants extends AppConstants {
  @override
  String get baseUrl => 'https://development.riverflow.solutions';
}
