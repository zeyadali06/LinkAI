import 'package:linkai/core/failures/request_result.dart';

class InterviewMessageFailure extends Failed {
  InterviewMessageFailure(super.data) {
    message = _getMessage(data);
  }

  late String message;

  String _getMessage(dynamic e) {
    if (e["error"] == "Suspicious activity detected!") {
      return "Improper word, Please write valid message";
    } else {
      return "Something went wrong, try again later!";
    }
  }
}
