class AppConstants {
  String get baseUrl => 'https://riverflow.solutions';

  Duration get connectTimeout => const Duration(seconds: 30);

  Duration get responseTimeOut => const Duration(seconds: 30);

  String get clientId => 'id.ncs-develop.com';

  String get redirectUrl => 'com.example.flutter_base://login-callback';

  String get androidIssuer => 'http://10.0.2.2:8080/realms/ncs-develop';

  String get iosIssuer => 'http://localhost:8080/realms/ncs-develop';
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
