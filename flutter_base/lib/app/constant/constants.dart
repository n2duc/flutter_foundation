class AppConstants {
  String get baseUrl => 'https://riverflow.solutions';
}

// for stagging
class StaggingAppConstants extends AppConstants {
  @override
  String get baseUrl => 'https://stagging.riverflow.solutions';
}

// for development
class DevelopmentAppConstants extends AppConstants {
  @override
  String get baseUrl => 'https://development.riverflow.solutions';
}
