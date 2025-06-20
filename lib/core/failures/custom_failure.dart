import 'package:linkai/core/failures/request_result.dart';

class CustomFailure extends Failed {
  const CustomFailure(this.message) : super(null);

  final String message;

  @override
  String toString() {
    return message;
  }
}
