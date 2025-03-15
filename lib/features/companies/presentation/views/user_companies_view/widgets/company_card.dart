import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/companies/presentation/manger/cubit/companies_cubit.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_tag.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.companyModel});
  final CompanyModel companyModel;
  @override
  Widget build(BuildContext context) {
        return GestureDetector(
      onTap: () {
        
        GoRouter.of(context).push(AppRouter.companyDetailsView, extra: companyModel);
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
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Expanded(
                    child: Text(
                      companyModel.companyName,
                      style: AppStyles.bold18(context, Colors.blueAccent),
                    ),
                  ),
                  JobTag(text: companyModel.role??''),
                  companyModel.role?.toLowerCase() =="owner" ?IconButton(onPressed: () {
                    GoRouter.of(context).push(AppRouter.editCompanyView, extra: {'companyModel': companyModel,'companiesCubit': context.read<CompaniesCubit>(),});
                  }, icon: const Icon(Icons.edit)):const SizedBox(),
                ],
              ),

              const SizedBox(height: 5),

              // Company & Location
              Text(
                companyModel.address,
                style: AppStyles.bold14(
                  context,
                  BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.blueGrey : Colors.white70,
                ),
              ),

              const SizedBox(height: 5),
              Text(
                "from ${companyModel.minEmployees} to ${companyModel.maxEmployees} Employee",
                style: AppStyles.bold14(
                  context,
                  BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.grey[500] : Colors.white60,
                ),
              ), 
              // // Experience
              // Text(
              //   jobModel.experience,
              //   style: AppStyles.bold14(
              //     context,
              //     BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.grey[500] : Colors.white60,
              //   ),
              // ),
              // const SizedBox(height: 5),

              // // Technical Skills
              // Text(
              //   "${jobModel.technicalSkills.join(', ')}, ${jobModel.softSkills.join(', ')}",
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: AppStyles.bold14(
              //     context,
              //     BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.black54 : Colors.white,
              //   ),
              // ),
              
              // const SizedBox(height: 8),

              // // Time Ago
              // Text(
              //   "${DateTime.now().difference(DateTime.parse(jobModel.createdAt)).inDays} days ago",
              //   style: AppStyles.defaultStyle(
              //     context,
              //     BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.green : Colors.white38,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  
  }
}