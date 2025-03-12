import 'package:get_it/get_it.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/services/ip_manager.dart';
import 'package:linkai/core/services/shared_preference.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';
import 'package:linkai/features/splash/data/repo/auto_login_repo.dart';

abstract class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton<IPManager>(
      IPManager(),
    );
    await getIt<IPManager>().getDeviceIP();

    getIt.registerSingleton<SharedPreferenceServices>(
      SharedPreferenceServices(),
    );

    getIt.registerSingleton<ApiManager>(
      const ApiManager(),
    );

    getIt.registerSingleton<AutoLoginRepo>(
      AutoLoginRepo(getIt<ApiManager>()),
    );

    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(getIt<ApiManager>()),
    );

    getIt.registerSingleton<AuthModel>(
      AuthModel(),
    );
  }
}
