import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/presentation/manager/job_interview_history_cubit/job_interview_history_cubit.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_interview_history_hr_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class JobInterviewHistoryHRView extends StatelessWidget {
  const JobInterviewHistoryHRView({super.key});

  static List<InterviewHistoryItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobInterviewHistoryCubit, JobInterviewHistoryState>(
      listener: (context, state) {
        if (state is JobInterviewHistoryListSuccess) {
          _items = state.models;
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
            body: JobInterviewHistoryHRViewBody(items: _items),
          ),
        );
      },
    );
  }
}
