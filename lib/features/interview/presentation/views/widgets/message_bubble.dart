import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_assets.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/interview/data/models/message_item_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.model});

  final MessageItemModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(Assets.imagesSplash),
        ),
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
      ],
    );
  }
}
