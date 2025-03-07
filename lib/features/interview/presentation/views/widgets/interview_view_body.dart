import 'package:flutter/material.dart';
import 'package:linkai/features/interview/data/models/message_item_model.dart';
import 'package:linkai/features/interview/data/models/message_type_enum.dart';
import 'package:linkai/features/interview/presentation/views/widgets/interview_text_field.dart';
import 'package:linkai/features/interview/presentation/views/widgets/message_bubble.dart';

class InterviewViewBody extends StatelessWidget {
  const InterviewViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      MessageBubble(
                        model: MessageItemModel(message: "1", type: MessageType.sended),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(message: "2", type: MessageType.recieved),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(message: "3", type: MessageType.sended),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(
                          message: "4o1jpij4pifh1ovb[o4bivb1obobvjb1j4nlmeknvwqkmcckmkmkeckmcekmkjrrrrrrrrqkjkjvmmmm m m m m m m m m m m m m m m m m m m mm m m m m m m m",
                          type: MessageType.recieved,
                        ),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(message: "5hvo4h3rv;b23ovb23vbj;b35;gjb", type: MessageType.recieved),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(
                          message: "4o1jpij4pifh1ovb[o4bivb1obobvjb1j4nlmeknvwqkmcckmkmkeckmcekmkjrrrrrrrrqkjkjvmmmm m m m m m m m m m m m m m m m m m m mm m m m m m m m",
                          type: MessageType.recieved,
                        ),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(
                          message: "4o1jpij4pifh1ovb[o4bivb1obobvjb1j4nlmeknvwqkmcckmkmkeckmcekmkjrrrrrrrrqkjkjvmmmm m m m m m m m m m m m m m m m m m m mm m m m m m m m",
                          type: MessageType.recieved,
                        ),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(
                          message: "4o1jpij4pifh1ovb[o4bivb1obobvjb1j4nlmeknvwqkmcckmkmkeckmcekmkjrrrrrrrrqkjkjvmmmm m m m m m m m m m m m m m m m m m m mm m m m m m m m",
                          type: MessageType.recieved,
                        ),
                      ),
                      SizedBox(height: 10),
                      MessageBubble(
                        model: MessageItemModel(
                          message: "4o1jpij4pifh1ovb[o4bivb1obobvjb1j4nlmeknvwqkmcckmkmkeckmcekmkjrrrrrrrrqkjkjvmmmm m m m m m m m m m m m m m m m m m m mm m m m m m m m",
                          type: MessageType.recieved,
                        ),
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: InterviewTextField(),
          ),
        ],
      ),
    );
  }
}
