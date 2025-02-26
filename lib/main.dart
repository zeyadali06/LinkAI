import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/services/shared_preference.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_themes.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppThemeCubit>(
      create: (context) => AppThemeCubit(ServiceLocator.getIt<SharedPreferenceServices>())..getTheme(),
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "LinkAI",
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            // themeMode: BlocProvider.of<AppThemeCubit>(context).appTheme,
            themeMode: ThemeMode.dark,
            color: Theme.of(context).scaffoldBackgroundColor,
            darkTheme: AppThemes.darkTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
