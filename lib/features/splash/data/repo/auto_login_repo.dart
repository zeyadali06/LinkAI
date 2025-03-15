import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';

class AutoLoginRepo {
  const AutoLoginRepo(this._apiManager);

  final ApiManager _apiManager;

  Future<RequestResault> autoLogin() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'user_token');

      if (token == null) {
        return RequestResault.failure(
          const CustomFailure('No stored token found'),
        );
      }

      final Map<String, dynamic> userData = await _apiManager.get(ApiConstants.userData, token: token);

      UserModel.instance.token = token;
      UserModel.instance.setFromJson(userData["user"]);

      return RequestResault.success(token);
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Auto login failed"),
      );
    }
  }
}
