import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/logo.dart';
import 'package:linkai/core/widgets/person_avatar.dart';
import 'package:linkai/features/interview/data/models/message_item_model.dart';
import 'package:linkai/features/interview/data/models/message_type_enum.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.model});

  final MessageItemModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: model.type == MessageType.recieved ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.type == MessageType.recieved) const Logo(width: 30, animate: true),
        Container(
          margin: const EdgeInsets.only(top: 5),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            model.message,
            style: AppStyles.normal18(context),
          ),
        ),
        if (model.type == MessageType.sended) const PersonAvatar(),
      ],
    );
  }
}
