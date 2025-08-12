import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() async {
    await DevelopmentServiceLocator().setup();
    return const App();
  });
}
