import 'package:linkai/core/services/ip_manager.dart';
import 'package:linkai/core/utils/service_locator.dart';

abstract class ApiConstants {
  static const int port = 3000;
  static final String baseURL = "http://${ServiceLocator.getIt<IPManager>().ip}:$port";
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String sendOTP = "/auth/send-otp";
  static const String sendOTPForgetPassword = "/auth/send-otp-forget-password";
  static const String forgetPassword = "/auth/forget-password";
  static const String refreshToken = "/auth/refresh-token";
  static const String userData = "/users";
  static const String getJobs = "/jobs/filter";
  static const String applyForJob = "/jobs/apply";
  static const String addJob = "/jobs/add";
  static const String updateJob = "/jobs";
  static const String deleteJob = "/jobs";
  static const String companies = "/companies";
}

