import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linkai/core/utils/app_constants.dart';
import 'package:linkai/features/authentication/data/models/forget_password_model.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';

class AuthDatasource {
  const AuthDatasource();

  Future<Map<String, dynamic>> register(RegisterModel registerModel) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/register'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    Map data = registerModel.toJson();
    data["DOB"] = DateTime.now().subtract(const Duration(days: 7000)).toIso8601String();

    request.body = json.encode(data);

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/login'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    Map data = loginModel.toJson();

    request.body = json.encode(data);

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> sendOTP(String email) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/send-otp'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    request.body = json.encode({"email": email});

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> sendForgetPasswordOTP(String email) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/send-otp-forget-password'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    request.body = json.encode({"email": email});

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> forgetPassword(ForgetPasswordModel model) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/forget-password'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    Map data = model.toJson();

    request.body = json.encode(data);

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }

  Future<Map<String, dynamic>> refreshToken(String token) async {
    final http.Request request = http.Request('POST', Uri.parse('${AppConstants.baseURL}/auth/refresh-token'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    request.body = json.encode({"refreshToken": token});

    final http.StreamedResponse response = await request.send();

    return json.decode(await response.stream.bytesToString());
  }
}
