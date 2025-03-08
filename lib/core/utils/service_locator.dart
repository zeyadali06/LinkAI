import 'package:get_it/get_it.dart';
import 'package:linkai/core/services/shared_preference.dart';
import 'package:linkai/features/authentication/data/datasources/auth_datasource.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';
import 'package:linkai/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

abstract class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton<SharedPreferenceServices>(
      SharedPreferenceServices(),
    );

    getIt.registerSingleton<AuthDatasource>(
      const AuthDatasource(),
    );

    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(getIt<AuthDatasource>()),
    );

    getIt.registerSingleton<RegisterModel>(
      RegisterModel(),
    );

    getIt.registerSingleton<LoginModel>(
      LoginModel(),
    );
  }
}
