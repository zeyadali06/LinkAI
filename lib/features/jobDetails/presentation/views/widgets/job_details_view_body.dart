import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_tag.dart';
import 'package:linkai/features/jobDetails/presentation/manager/apply_job_cubit/apply_job_cubit.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class JobdetailsViewBody extends StatelessWidget {
  const JobdetailsViewBody({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    debugPrint(jobModel.id);
    debugPrint(UserModel.instance.token);
    return BlocConsumer<ApplyJobCubit, ApplyJobState>(
      listener: (context, state) {
        if (state is ApplyJobInterviewed) {
          jobModel.status = "You have already entered this interview";
        } else if (state is ApplyJobApplied) {
          jobModel.status = "Interview now";
        } else if (state is ApplyJobNone) {
          jobModel.status = "Upload Your CV";
        }
      },
      builder: (context, state) {
        if (state is ApplyJobLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // job title
                          Text(
                            jobModel.title,
                            style: AppStyles.bold22(context, Colors.blueAccent),
                          ),
                          const SizedBox(height: 5),

                          // company name and location
                          if (jobModel.company != null)
                            Text(
                              "${jobModel.company?.companyName} - ${jobModel.company?.address}",
                              style: AppStyles.bold18(
                                context,
                                BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.blueGrey : Colors.white70,
                              ),
                            ),
                          Text(
                            "${DateTime.now().difference(DateTime.parse(jobModel.createdAt ?? '')).inDays} days ago",
                            style: AppStyles.defaultStyle(
                              context,
                              BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.green : Colors.white38,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Divider(),

                          // worklocation and workingtime
                          Text(
                            "Job Detials",
                            style: AppStyles.bold18(context),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            spacing: 8,
                            children: [
                              JobTag(text: jobModel.workingTime),
                              JobTag(text: jobModel.workLocation),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(),

                          // experience
                          Text(
                            "Experience",
                            style: AppStyles.bold18(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            jobModel.experience,
                            style: AppStyles.normal16(context),
                          ),
                          const SizedBox(height: 15),
                          const Divider(),

                          // job desc
                          Text(
                            "Full Job Description",
                            style: AppStyles.bold18(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            jobModel.description,
                            style: AppStyles.normal16(context),
                          ),
                          const SizedBox(height: 15),
                          const Divider(),

                          // tech skills
                          Text(
                            "Technical Skills",
                            style: AppStyles.bold18(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            jobModel.technicalSkills.join(', '),
                            style: AppStyles.normal16(context),
                          ),
                          const SizedBox(height: 15),
                          const Divider(),
                          Text(
                            "Soft Skills",
                            style: AppStyles.bold18(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            jobModel.softSkills.join(', '),
                            style: AppStyles.normal16(context),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: CustomButton(
                  onPressed: () async {
                    if (jobModel.status == "Upload Your CV") {
                      context.read<ApplyJobCubit>().uploadCV(jobModel.id!);
                    } else if (jobModel.status == "Interview now") {
                      context.read<ApplyJobCubit>().updateApplicationStatus(jobModel.id!);
                      GoRouter.of(context).push(AppRouter.interviewView, extra: jobModel);
                    }
                  },
                  text: jobModel.status ?? "Something went wrong",
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
