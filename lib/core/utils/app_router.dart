import 'package:go_router/go_router.dart';
import 'package:linkai/features/authentication/presentation/views/login_view.dart';
import 'package:linkai/features/authentication/presentation/views/register_view.dart';
import 'package:linkai/features/home/presentation/views/home_view.dart';
import 'package:linkai/features/profile/presentation/views/profile_view.dart';
import 'package:linkai/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String splashView = "/splashView";
  static const String homeView = "/homeView";
  static const String loginView = "/loginView";
  static const String registerView = "/registerView";
  static const String profileView = "/profileView";

  static final GoRouter router = GoRouter(
    initialLocation: splashView,
    routes: <RouteBase>[
      GoRoute(
        path: splashView,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: homeView,
        builder: (context, state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: registerView,
        builder: (context, state) {
          return const RegisterView();
        },
      ),
      GoRoute(
        path: profileView,
        builder: (context, state) {
          return const ProfileView();
        },
      ),
    ],
  );
}
