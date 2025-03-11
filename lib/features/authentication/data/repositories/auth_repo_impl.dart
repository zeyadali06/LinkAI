import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/otp_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/authentication/data/models/forget_password_model.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/domain/repositories/auth_repo_interface.dart';

class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<RequestResault> register(AuthModel model) async {
    try {
      final Map<String, dynamic> data = model.toJson();
      data["DOB"] = DateTime.now().subtract(const Duration(days: 7000)).toIso8601String();
      final Map<String, dynamic> res = await _apiManager.post(data, ApiConstants.register);

      if (res["success"]) {
        await login(model);

        return RequestResault.success(null);
      } else {
        return RequestResault.failure(OtpFailure(res));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> login(AuthModel model) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post(model.toLoginJson(), ApiConstants.login);

      if (res["success"]) {
        UserModel.instance.token = res["token"];
        final Map<String, dynamic> userData = await _apiManager.get(ApiConstants.userData, token: UserModel.instance.token);
        UserModel.instance.setFromJson(userData["user"]);
        const storage = FlutterSecureStorage();
        await storage.write(key: 'user_token', value: UserModel.instance.token);
        return RequestResault.success(UserModel.instance.token);
      } else {
        return RequestResault.failure(const CustomFailure("Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> sendOTP(String email) async {
    try {
      Map<String, dynamic> res = await _apiManager.post({"email": email}, ApiConstants.sendOTP);

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(OtpFailure(res));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> refreshToken(String oldToken) async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    return RequestResault.success(null);
  }

  @override
  Future<RequestResault> forgetPassword(ForgetPasswordModel model) async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    return RequestResault.success(null);
  }
}
