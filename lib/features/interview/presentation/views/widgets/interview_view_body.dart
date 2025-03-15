import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/interview/presentation/manager/interview_cubit/interview_cubit.dart';
import 'package:linkai/features/interview/presentation/views/widgets/interview_text_field_container.dart';
import 'package:linkai/features/interview/presentation/views/widgets/message_bubble.dart';

class InterviewViewBody extends StatelessWidget {
  const InterviewViewBody({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: () {
                      final List<Widget> messages = List.generate(
                        BlocProvider.of<InterviewCubit>(context).chat.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: MessageBubble(
                              model: BlocProvider.of<InterviewCubit>(context).chat[index],
                            ),
                          );
                        },
                      );
                      messages.add(SizedBox(height: MediaQuery.sizeOf(context).height));
                      return messages;
                    }.call(),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: InterviewTextFieldContainer(chatId: chatId),
          ),
        ],
      ),
    );
  }
}
