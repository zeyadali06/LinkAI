import 'package:linkai/features/interview/data/models/message_type_enum.dart';

class MessageItemModel {
  final String message;
  final MessageType type;

  const MessageItemModel({
    required this.message,
    required this.type,
  });
}
