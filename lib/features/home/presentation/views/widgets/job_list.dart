import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/home/presentation/mangers/cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_card.dart';

class JobsListPage extends StatelessWidget {
  const JobsListPage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobsCubit, JobsState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
     
        if (state is JobsError){
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
        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
      },
  
    );
  }
}
