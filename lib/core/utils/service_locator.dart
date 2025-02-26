import 'package:get_it/get_it.dart';
import 'package:linkai/core/services/shared_preference.dart';

abstract class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton<SharedPreferenceServices>(
      SharedPreferenceServices(),
    );
  }
}
