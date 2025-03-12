import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/interview/presentation/views/widgets/timer_widget.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class InterviewTextField extends StatefulWidget {
  const InterviewTextField({super.key});

  @override
  State<InterviewTextField> createState() => _InterviewTextFieldState();
}

class _InterviewTextFieldState extends State<InterviewTextField> {
  late bool recording;

  @override
  void initState() {
    recording = false;
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
              TextField(
                minLines: 1,
                maxLines: 5,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                style: AppStyles.normal18(context, Theme.of(context).textTheme.bodyLarge!.color),
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Send a message...',
                  hintStyle: AppStyles.normal18(context, Theme.of(context).hintColor),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!recording)
                  GestureDetector(
                    onTap: () {
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
                    onTap: () {
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
                  onPressed: () {
                    recording = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder getBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.dark ? const Color(0xff0e1219) : const Color(0xfff3f0fa)),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
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
