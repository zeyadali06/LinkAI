import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
