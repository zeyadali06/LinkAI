import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_list.dart';
import 'package:linkai/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const SearchTextField(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.white : Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.createJobView);
            },
            icon: Icon(
              Icons.add_circle_outline_sharp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: const JobsListPage(),
    );
  }
}
