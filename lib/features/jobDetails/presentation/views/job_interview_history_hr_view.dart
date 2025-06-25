import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/data/models/job_application_model.dart';
import 'package:linkai/features/jobDetails/presentation/manager/job_interview_history_cubit/job_interview_history_cubit.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_application_history.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_interview_history_hr.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class JobInterviewHistoryHRView extends StatefulWidget {
  const JobInterviewHistoryHRView({super.key, required this.jobId});

  final String jobId;

  @override
  State<JobInterviewHistoryHRView> createState() => _JobInterviewHistoryHRViewState();
}

class _JobInterviewHistoryHRViewState extends State<JobInterviewHistoryHRView> with SingleTickerProviderStateMixin {
  late List<InterviewHistoryItem> _interviews;
  late List<JobApplicationModel> _applications;
  late TabController _tabController;

  @override
  void initState() {
    _interviews = [];
    _applications = [];
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<JobInterviewHistoryCubit>(context).getJobInterviewHistoryForHR(widget.jobId);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == 0) {
        BlocProvider.of<JobInterviewHistoryCubit>(context).getJobInterviewHistoryForHR(widget.jobId);
      } else {
        BlocProvider.of<JobInterviewHistoryCubit>(context).getJobApplications(widget.jobId);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobInterviewHistoryCubit, JobInterviewHistoryState>(
      listener: (context, state) {
        if (state is JobInterviewHistoryListSuccess) {
          _interviews = state.models;
        } else if (state is JobInterviewApplicationListSuccess) {
          _applications = state.models;
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
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Interviews"),
                  Tab(text: "CVs"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                JobInterviewHistoryHR(items: _interviews),
                JobApplicationHistory(items: _applications),
              ],
            ),
          ),
        );
      },
    );
  }
}
