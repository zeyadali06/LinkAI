import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_list.dart';
import 'package:linkai/features/home/presentation/views/widgets/search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserModel.instance.token);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const SearchTextField(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => GoRouter.of(context).push(AppRouter.settings),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
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
