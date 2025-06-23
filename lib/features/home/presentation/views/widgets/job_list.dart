import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_card.dart';

class JobsListPage extends StatelessWidget {
  final CompanyModel? companyModel;
  const JobsListPage({super.key, this.companyModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobsCubit, JobsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is JobsError) {
          return Center(child: Text(state.message));
        }
        if (state is JobsLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.jobs.length,
            itemBuilder: (context, index) {
              return JobCard(
                jobModel: state.jobs[index],
                companyModel: companyModel,
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
