import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/enums/role_enum.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/core/models/company_model.dart';
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
import 'package:linkai/features/authentication/presentation/views/register_view.dart';
import 'package:linkai/features/authentication/presentation/views/role_view.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/companies/presentation/views/add_company_view/add_company_view.dart';
import 'package:linkai/features/companies/presentation/views/company_details_view/company_details_view.dart';
import 'package:linkai/features/companies/presentation/views/edit_company_view/edit_company_view.dart';
import 'package:linkai/features/createJob/presentation/views/create_job_view.dart';
import 'package:linkai/features/editJob/presentation/views/edit_job_view.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/navigator_view.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';
import 'package:linkai/features/interview/presentation/manager/interview_cubit/interview_cubit.dart';
import 'package:linkai/features/interview/presentation/views/interview_view.dart';
import 'package:linkai/features/interview/presentation/views/score_view.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/presentation/manager/job_interview_history_cubit/job_interview_history_cubit.dart';
import 'package:linkai/features/jobDetails/presentation/views/job_details_view.dart';
import 'package:linkai/features/jobDetails/presentation/views/job_interview_history_hr_view.dart';
import 'package:linkai/features/jobDetails/presentation/views/job_interview_history_user_view.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_interview_history_item_view.dart';
import 'package:linkai/features/profile/presentation/managers/change_password_cubit/change_password_cubit.dart';
import 'package:linkai/features/profile/presentation/views/profile_view.dart';
import 'package:linkai/features/splash/data/repo/auto_login_repo.dart';
import 'package:linkai/features/splash/presentation/manager/auto_login_cubit/auto_login_cubit.dart';
import 'package:linkai/features/splash/presentation/views/splash_view.dart';
import '../../features/jobDetails/data/repo_impl/job_details_repo_impl.dart';
import '../../features/jobDetails/presentation/manager/apply_job_cubit/apply_job_cubit.dart';
import '../../features/profile/domain/useCases/changeNameuseCase/change_name_use_case.dart';
import '../../features/profile/domain/useCases/passwordUseCase/change_password_use_case.dart';
import '../../features/profile/domain/useCases/changeEmailCheckPasswordUseCase/change_email_check_password_use_case.dart';
import '../../features/profile/domain/useCases/changeEmailSendOTPUseCase/change_email_send_otp_use_case.dart';
import '../../features/profile/domain/useCases/changeEmailEnterNewEmailUseCase/change_email_enter_new_email_use_case.dart';
import '../../features/profile/presentation/managers/change_name_cubit/change_name_cubit.dart';
import '../../features/profile/presentation/managers/change_email_cubit/change_email_cubit.dart';
import '../../features/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import '../../features/profile/presentation/views/change_email.dart';
import '../../features/profile/presentation/views/change_name.dart';
import '../../features/profile/presentation/views/change_password.dart';
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
  static const String editJobView = "/editJobView";
  static const String jobDetailsView = "/jobDetailsView";
  static const String addCompanyView = "/addCompanyView";
  static const String companyDetailsView = "/companyDetailsView";
  static const String settings = "/settings";
  static const String changeName = "/changeName";
  static const String changeEmail = "/changeEmail";
  static const String changePassword = "/changePassword";
  static const String scoreView = "/scoreView";
  static const String roleView = "/roleView";
  static const String jobInterviewHistoryView = "/jobInterviewHistoryView";
  static const String jobInterviewHistoryItemView = "/jobInterviewHistoryItemView";
  static const String registerView = "/registerView";

  static const String editCompanyView = "/editCompanyView";
  static final GoRouter router = GoRouter(
    initialLocation: splashView,
    routes: <RouteBase>[
      GoRoute(
        path: splashView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => AutoLoginCubit(ServiceLocator.getIt<AutoLoginRepo>())..autoLogin(),
              child: const SplashView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: editCompanyView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider.value(
              value: (state.extra as Map<String, dynamic>)['companiesCubit'] as CompaniesCubit,
              child: EditCompanyView(
                companyModel: (state.extra as Map<String, dynamic>)['companyModel'] as CompanyModel,
              ),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: addCompanyView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider.value(
              value: state.extra as CompaniesCubit,
              child: const AddCompanyView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: changePassword,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => ChangePasswordCubit(ServiceLocator.getIt<ChangePasswordUseCase>()),
              child: const ChangePassword(),
            ),
            transitionsBuilder: bottomUpTransition,
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
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => LoginCubit(ServiceLocator.getIt<AuthRepo>()),
              child: const LoginView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: changeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => ChangeNameCubit(ServiceLocator.getIt<ChangeNameUseCase>())),
                BlocProvider.value(
                  value: state.extra as ProfileCubit,
                ),
              ],
              child: const ChangeName(),
            ),
            transitionsBuilder: bottomUpTransition,
          );
        },
      ),
      GoRoute(
        path: changeEmail,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => ChangeEmailCubit(
                ServiceLocator.getIt<ChangeEmailCheckPasswordUseCase>(),
                ServiceLocator.getIt<ChangeEmailSendOTPUseCase>(),
                ServiceLocator.getIt<ChangeEmailEnterNewEmailUseCase>(),
              ),
              child: const ChangeEmail(),
            ),
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
        path: companyDetailsView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => JobsCubit()..getJobsByCompanyId((state.extra as CompanyModel).id ?? ''),
              child: CompanyDetailsView(company: state.extra as CompanyModel),
            ),
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
              create: (context) => RegisterCubit(ServiceLocator.getIt<AuthRepo>()),
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
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => InterviewCubit(ServiceLocator.getIt<InterviewRepo>(), ServiceLocator.getIt<AudioManager>()),
              child: InterviewView(state.extra as JobModel),
            ),
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
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => JobsCubit(),
              child: CreateJobView(companyModel: state.extra as CompanyModel),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: editJobView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => JobsCubit(),
              child: EditJobView(jobModel: state.extra as JobModel),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: jobDetailsView,
        pageBuilder: (context, state) {
          var arguments = state.extra as JobModel;
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) {
                if (arguments.status != null) {
                  return ApplyJobCubit(ServiceLocator.getIt<JobDetailsRepoImpl>());
                } else {
                  return ApplyJobCubit(ServiceLocator.getIt<JobDetailsRepoImpl>())..handleUserApplication(arguments.id!);
                }
              },
              child: JobdetailsView(jobModel: arguments),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: scoreView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: ScoreView(state.extra as ScoreModel),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: roleView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            child: RoleView(),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: jobInterviewHistoryItemView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: JobInterviewHistoryItemView(item: state.extra as InterviewHistoryItem),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: jobInterviewHistoryView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => JobInterviewHistoryCubit(ServiceLocator.getIt<JobDetailsRepoImpl>()),
              child: UserModel.instance.role == Role.user
                  ? JobInterviewHistoryUserView(jobId: state.extra as String) //
                  : JobInterviewHistoryHRView(jobId: state.extra as String),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
      GoRoute(
        path: registerView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => OtpCubit(ServiceLocator.getIt<AuthRepo>()),
              child: const RegisterView(),
            ),
            transitionsBuilder: customTransition,
          );
        },
      ),
    ],
  );

  static Widget customTransition(context, animation, secondaryAnimation, child) {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset(0.0, 0.0);
    const Cubic curve = Curves.easeInOut;

    final Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final Animation<Offset> offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  static Widget bottomUpTransition(context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
