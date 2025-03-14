import 'package:flutter/cupertino.dart';
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
import 'package:linkai/features/createJob/presentation/views/create_job_view.dart';
import 'package:linkai/features/home/presentation/views/navigator_view.dart';
import 'package:linkai/features/interview/presentation/views/interview_view.dart';
import 'package:linkai/features/profile/presentation/views/profile_view.dart';
import 'package:linkai/features/splash/data/repo/auto_login_repo.dart';
import 'package:linkai/features/splash/presentation/manager/auto_login_cubit/auto_login_cubit.dart';
import 'package:linkai/features/splash/presentation/views/splash_view.dart';

import '../../features/profile/presentation/views/change_email.dart';
import '../../features/profile/presentation/views/change_name.dart';
import '../../features/settings/presentation/views/settings.dart';

abstract class AppRouter {
  static const String splashView = "/splashView";
  static const String navigatorView = "/navigatorView";
  static const String loginView = "/loginView";
  static const String profileView = "/profileView";
  static const String passwordView = "/passwordView";
  static const String passwordConfimationView = "/passwordConfimationView";
  static const String phoneNumberView = "/phoneNumberView";
  static const String emailVerificationView = "/emailVerificationView";
  static const String forgetPasswordView = "/forgetPasswordView";
  static const String interviewView = "/interviewView";
  static const String nameView = "/nameView";
  static const String createJobView = "/createJobView";
  static const String settings = "/settings";
  static const String changeName = "/changeName";
  static const String changeEmail = "/changeEmail";

  static final GoRouter router = GoRouter(
    initialLocation: splashView,
    routes: <RouteBase>[
      GoRoute(
        path: splashView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) =>
                  AutoLoginCubit(ServiceLocator.getIt<AutoLoginRepo>())
                    ..autoLogin(),
              child: const SplashView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: navigatorView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: NavigatorView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: settings,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: Settings(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: loginView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: LoginView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: changeName,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: ChangeName(),
            transitionsBuilder: bottomUpTransition,
          );
        },
      ),
      GoRoute(
        path: changeEmail,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: ChangeEmail(),
            transitionsBuilder: bottomUpTransition,
          );
        },
      ),
      GoRoute(
        path: profileView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: ProfileView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: passwordView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => LoginCubit(ServiceLocator.getIt<AuthRepo>()),
              child: const PasswordView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: passwordConfimationView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: PasswordConfimationView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: phoneNumberView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => OtpCubit(ServiceLocator.getIt<AuthRepo>()),
              child: const PhoneNumberView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: emailVerificationView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) =>
                  RegisterCubit(ServiceLocator.getIt<AuthRepo>()),
              child: const EmailVerificationView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: forgetPasswordView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: ForgetPasswordView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: interviewView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: InterviewView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: nameView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: NameView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: createJobView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: CreateJobView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
    ],
  );

  static Widget customTransition(
      context, animation, secondaryAnimation, child) {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset(0.0, 0.0);
    const Cubic curve = Curves.easeInOut;

    final Animatable<Offset> tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final Animation<Offset> offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  static Widget bottomUpTransition(
      context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
