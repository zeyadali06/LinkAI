import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/person_avatar.dart';
import 'package:linkai/features/home/presentation/views/widgets/job_list.dart';
import 'package:linkai/features/home/presentation/views/widgets/search_text_field.dart';

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
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: PersonAvatar(),
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
