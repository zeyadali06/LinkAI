import 'package:go_router/go_router.dart';
import 'package:linkai/features/authentication/presentation/views/email_verification_view.dart';
import 'package:linkai/features/authentication/presentation/views/login_view.dart';
import 'package:linkai/features/authentication/presentation/views/password_confimation_view.dart';
import 'package:linkai/features/authentication/presentation/views/password_view.dart';
import 'package:linkai/features/authentication/presentation/views/phone_number_view.dart';
import 'package:linkai/features/home/presentation/views/home_view.dart';
import 'package:linkai/features/profile/presentation/views/profile_view.dart';
import 'package:linkai/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String splashView = "/splashView";
  static const String homeView = "/homeView";
  static const String loginView = "/loginView";
  static const String profileView = "/profileView";
  static const String passwordView = "/passwordView";
  static const String passwordConfimationView = "/passwordConfimationView";
  static const String phoneNumberView = "/phoneNumberView";
  static const String emailVerificationView = "/emailVerificationView";

  static final GoRouter router = GoRouter(
    initialLocation: emailVerificationView,
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
        path: profileView,
        builder: (context, state) {
          return const ProfileView();
        },
      ),
      GoRoute(
        path: passwordView,
        builder: (context, state) {
          return const PasswordView();
        },
      ),
      GoRoute(
        path: passwordConfimationView,
        builder: (context, state) {
          return const PasswordConfimationView();
        },
      ),
      GoRoute(
        path: phoneNumberView,
        builder: (context, state) {
          return const PhoneNumberView();
        },
      ),
      GoRoute(
        path: emailVerificationView,
        builder: (context, state) {
          return const EmailVerificationView();
        },
      ),
    ],
  );
}
