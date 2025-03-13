import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/interview/presentation/manager/interview_cubit/interview_cubit.dart';
import 'package:linkai/features/interview/presentation/views/widgets/interview_text_field.dart';
import 'package:linkai/features/interview/presentation/views/widgets/timer_widget.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class InterviewTextFieldContainer extends StatefulWidget {
  const InterviewTextFieldContainer({super.key, required this.chatId});

  final String chatId;

  @override
  State<InterviewTextFieldContainer> createState() => _InterviewTextFieldContainerState();
}

class _InterviewTextFieldContainerState extends State<InterviewTextFieldContainer> {
  late bool recording;
  late String message;
  late String voicePath;

  @override
  void initState() {
    recording = false;
    message = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xff0c61fd), Color(0xff02aef2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: getContainerColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            if (recording)
              const SizedBox()
            else
              InterviewTextField(
                onChanged: (value) {
                  message = value;
                },
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!recording)
                  GestureDetector(
                    onTap: () async {
                      voicePath = await BlocProvider.of<InterviewCubit>(context).startRecord();

                      recording = true;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.mic_none,
                      size: 30,
                      color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.dark ? Colors.white : Colors.black,
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () async {
                      voicePath = await BlocProvider.of<InterviewCubit>(context).stopRecording();

                      recording = false;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                if (recording) const TimerWidget(),
                CustomButton(
                  text: "Send",
                  fitWidth: false,
                  gradient: recording
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xff0c61fd), Color(0xff02aef2)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                  buttonColor: Colors.white,
                  textColor: recording ? Colors.black : Colors.white,
                  onPressed: () async {
                    bool voice = recording;
                    recording = false;
                    setState(() {});

                    if (voice) {
                      voicePath = await BlocProvider.of<InterviewCubit>(context).stopRecording();
                      if (context.mounted) {
                        await BlocProvider.of<InterviewCubit>(context).sendVoice(voicePath);
                      }
                    } else {
                      if (message.isNotEmpty) {
                        await BlocProvider.of<InterviewCubit>(context).sendMessage(message, widget.chatId);
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getContainerColor(BuildContext context) {
    if (recording) {
      return Colors.transparent;
    } else if (BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.dark) {
      return const Color(0xff0e1219);
    } else {
      return const Color(0xfff3f0fa);
    }
  }
}
