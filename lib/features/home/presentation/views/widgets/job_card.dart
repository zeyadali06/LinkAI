import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_tag.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.jobModel,
    this.companyModel,
  });

  final JobModel jobModel;
  final CompanyModel? companyModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Job Details Page
        GoRouter.of(context).push(AppRouter.jobDetailsView, extra: jobModel);
      },
      child: Card(
        color: Theme.of(context).cardColor,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Title & Tags (Work Type + Work Location)
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      jobModel.title,
                      style: AppStyles.bold18(context, Colors.blueAccent),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      spacing: 5,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: JobTag(text: jobModel.workingTime),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: JobTag(text: jobModel.workLocation),
                        ),
                      ],
                    ),
                  ),
                  if (companyModel != null)
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.editJobView, extra: jobModel);
                          },
                          icon: const Icon(Icons.edit, size: 18),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              ),

              const SizedBox(height: 5),

              // Company & Location
              if (jobModel.company != null)
                Text(
                  "${jobModel.company?.companyName} - ${jobModel.company?.address}",
                  style: AppStyles.bold14(
                    context,
                    BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.blueGrey : Colors.white70,
                  ),
                ),

              const SizedBox(height: 5),

              // Experience
              Text(
                jobModel.experience,
                style: AppStyles.bold14(
                  context,
                  BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.grey[500] : Colors.white60,
                ),
              ),
              const SizedBox(height: 5),

              // Technical Skills
              Text(
                "${jobModel.technicalSkills.join(', ')}, ${jobModel.softSkills.join(', ')}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.bold14(
                  context,
                  BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.black54 : Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Time Ago
              Text(
                "${DateTime.now().difference(DateTime.parse(jobModel.createdAt ?? '')).inDays} days ago",
                style: AppStyles.defaultStyle(
                  context,
                  BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.green : Colors.white38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
