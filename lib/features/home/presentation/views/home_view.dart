import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/features/home/presentation/mangers/cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserModel.instance.token);
    return BlocProvider(
      create: (context) => JobsCubit()..getJobs(),
      child: const HomeViewBody(),
    );
  }
}
