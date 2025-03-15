import 'package:get_it/get_it.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/core/services/ip_manager.dart';
import 'package:linkai/core/services/shared_preference.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';
import 'package:linkai/features/interview/data/repositories/interview_repo_impl.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';
import 'package:linkai/features/companies/data/repo/companies_repo.dart';
import 'package:linkai/features/companies/domain/repo/companies_repo.dart';
import 'package:linkai/features/splash/data/repo/auto_login_repo.dart';

import '../../features/profile/data/repos/profile_repo_impl.dart';
import '../../features/profile/domain/abstractRepos/profile_repo.dart';
import '../../features/profile/domain/useCases/changeNameuseCase/change_name_use_case.dart';

abstract class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton<IPManager>(
      IPManager(),
    );
    await getIt<IPManager>().getDeviceIP();

    getIt.registerSingleton<AudioManager>(
      AudioManager(),
    );
    await getIt<AudioManager>().init();

    getIt.registerSingleton<SharedPreferenceServices>(
      SharedPreferenceServices(),
    );

    getIt.registerSingleton<ApiManager>(
      const ApiManager(),
    );
    getIt.registerSingleton<CompaniesRepo>(
      CompaniesRepoImpl(getIt<ApiManager>()),
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

    getIt.registerSingleton<InterviewRepo>(
      InterviewRepoImpl(getIt<ApiManager>()),
    );
    getIt.registerSingleton<ProfileRepo>(
      ProfileRepoImpl(getIt<ApiManager>()),
    );
    getIt.registerSingleton<ChangeNameUseCase>(
      ChangeNameUseCase(getIt<ProfileRepo>()),
    );
  }
}
