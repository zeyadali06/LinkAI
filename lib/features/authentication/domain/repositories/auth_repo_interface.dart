import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/forget_password_model.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<RequestResault> register(AuthModel model);
  Future<RequestResault> login(AuthModel model);
  Future<RequestResault> forgetPassword(ForgetPasswordModel model);
  Future<RequestResault> refreshToken(String oldToken);
  Future<RequestResault> sendOTP(String email);
}
