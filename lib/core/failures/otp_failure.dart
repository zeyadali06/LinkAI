import 'package:linkai/core/failures/request_result.dart';

class OtpFailure extends Failed {
  OtpFailure(super.data) {
    message = _getMessage(data);
  }

  late String message;

  String _getMessage(dynamic e) {
    if (e["message"] == "User already exist") {
      return "Email already in use!";
    } else if (e["message"] == "wrong otp") {
      return "Invalid OTP!";
    } else {
      return "Something went wrong, try again later!";
    }
  }
}
