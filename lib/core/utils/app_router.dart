import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';
import 'package:linkai/features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:linkai/features/authentication/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:linkai/features/authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:linkai/features/authentication/presentation/views/email_verification_view.dart';
import 'package:linkai/features/authentication/presentation/views/forget_password_view.dart';
import 'package:linkai/features/authentication/presentation/views/login_view.dart';
import 'package:linkai/features/authentication/presentation/views/name_view.dart';
import 'package:linkai/features/authentication/presentation/views/password_confimation_view.dart';
import 'package:linkai/features/authentication/presentation/views/password_view.dart';
import 'package:linkai/features/authentication/presentation/views/phone_number_view.dart';
import 'package:linkai/features/home/presentation/views/home_view.dart';
import 'package:linkai/features/interview/presentation/views/interview_view.dart';
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
  static const String forgetPasswordView = "/forgetPasswordView";
  static const String interviewView = "/interviewView";
  static const String nameView = "/nameView";

  static final GoRouter router = GoRouter(
    initialLocation: loginView,
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
          return BlocProvider(
            create: (context) => LoginCubit(ServiceLocator.getIt<AuthRepo>()),
            child: const PasswordView(),
          );
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
          return BlocProvider(
            create: (context) => OtpCubit(ServiceLocator.getIt<AuthRepo>()),
            child: const PhoneNumberView(),
          );
        },
      ),
      GoRoute(
        path: emailVerificationView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => RegisterCubit(ServiceLocator.getIt<AuthRepo>()),
            child: const EmailVerificationView(),
          );
        },
      ),
      GoRoute(
        path: forgetPasswordView,
        builder: (context, state) {
          return const ForgetPasswordView();
        },
      ),
      GoRoute(
        path: interviewView,
        builder: (context, state) {
          return const InterviewView();
        },
      ),
      GoRoute(
        path: nameView,
        builder: (context, state) {
          return const NameView();
        },
      ),
    ],
  );
}
