import 'package:linkai/core/failures/request_result.dart';

class CustomException extends RequestFailed {
  CustomException(this.message) : super(null);

  final String message;
}
