import 'package:get_it/get_it.dart';

abstract class ServiceLocator {
  final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {}
}
