import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/presentation/manager/job_interview_history_cubit/job_interview_history_cubit.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_interview_history_user_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class JobInterviewHistoryUserView extends StatelessWidget {
  JobInterviewHistoryUserView({super.key, required this.jobId});

  InterviewHistoryItem? _item;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await BlocProvider.of<JobInterviewHistoryCubit>(context).getJobInterviewHistoryForUser(jobId);
      },
    );

    return BlocConsumer<JobInterviewHistoryCubit, JobInterviewHistoryState>(
      listener: (context, state) {
        if (state is JobInterviewHistorySuccess) {
          _item = state.model;
        } else if (state is JobInterviewHistoryFailed) {
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is JobInterviewHistoryLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).iconTheme.color,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: Text(
                "Interviews History",
                style: AppStyles.semiBold18(context),
              ),
            ),
            body: JobInterviewHistoryUserViewBody(item: _item),
          ),
        );
      },
    );
  }
}
