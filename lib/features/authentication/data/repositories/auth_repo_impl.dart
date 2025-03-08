import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/authentication/data/models/forget_password_model.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

class AuthRepoImpl extends AuthRepoInterface {
  @override
  Future<RequestResault> register(RegisterModel model) {
    
    throw UnimplementedError();
  }

  @override
  Future<RequestResault> login(LoginModel model) {
    throw UnimplementedError();
  }

  @override
  Future<RequestResault> sendOTP(String email) {
    throw UnimplementedError();
  }

  @override
  Future<RequestResault> refreshToken(String oldToken) {
    throw UnimplementedError();
  }

  @override
  Future<RequestResault> forgetPassword(ForgetPasswordModel model) {
    throw UnimplementedError();
  }
}
