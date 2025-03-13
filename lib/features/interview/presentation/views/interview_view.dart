import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/interview/presentation/manager/interview_cubit/interview_cubit.dart';
import 'package:linkai/features/interview/presentation/views/widgets/interview_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class InterviewView extends StatelessWidget {
  InterviewView(this.jobModel, {super.key});

  final JobModel jobModel;
  late String chatId = "";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async => await BlocProvider.of<InterviewCubit>(context).setupChat(jobModel),
    );

    return BlocConsumer<InterviewCubit, InterviewState>(
      listener: (context, state) {
        if (state is InterviewFailed) {
          showSnackBar(context, state.errorMessage);
        } else if (state is InterviewGetChatId) {
          chatId = state.chatId;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is InterviewLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              forceMaterialTransparency: true,
              title: Text(
                getTitle(),
                style: AppStyles.semiBold18(context),
              ),
            ),
            body: InterviewViewBody(chatId: chatId),
          ),
        );
      },
    );
  }

  String getTitle() {
    String title = jobModel.title.trim();
    if (!title.toLowerCase().contains("interview")) {
      title = "$title Interview";
    }
    return title;
  }
}
