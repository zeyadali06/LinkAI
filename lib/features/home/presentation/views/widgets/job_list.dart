import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/createJob/presentation/views/create_job_view.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_card.dart';

class JobsListPage extends StatelessWidget {
  final CompanyModel? companyModel;
  const JobsListPage({super.key, this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<JobsCubit, JobsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is JobsError) {
            return Center(child: Text(state.message));
          }
          if (state is JobsLoaded) {
            return ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                return JobCard(
                  jobModel: state.jobs[index],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: companyModel != null
          ? FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).push(
                  AppRouter.createJobView,
                  extra: companyModel,
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
