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

  static const String modelsBaseURL = "https://874b-34-138-31-14.ngrok-free.app";
  static const String startChat = "/start_chat";
  static const String sendMessage = "/chat";
  static const String userCompanies = "/companies/userCompanies";
  static const String uploadCompanyLogo = "/companies/uploadCompanyLogo";
  static const String uploadCompanyCover = "/companies/uploadCompanyCoverPic";
  static const String jobs = "/jobs";
}
