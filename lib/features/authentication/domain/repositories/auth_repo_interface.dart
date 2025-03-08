import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/forget_password_model.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<RequestResault> register(RegisterModel model);
  Future<RequestResault> login(LoginModel model);
  Future<RequestResault> forgetPassword(ForgetPasswordModel model);
  Future<RequestResault> refreshToken(String oldToken);
  Future<RequestResault> sendOTP(String email);
}
