import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/navigationCubit/navigation_cubit.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/layout/presentation/views/widgets/search_text_field.dart';

import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

import '../../../../setting/presentation/setting_view.dart';
import 'job_list.dart';

class LayoutViewBody extends StatelessWidget {
  const LayoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationCubit cubit = NavigationCubit.get(context);
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final List<Widget> screens = [const JobsListPage(),SettingView()];
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
                  color: BlocProvider.of<AppThemeCubit>(context).appTheme ==
                          ThemeMode.light
                      ? Colors.white
                      : Theme.of(context).iconTheme.color,
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
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: "setting"),
            ],
            onTap: (value) => cubit.selectTab(value),
          ),
          body: screens[state.index],
        );
      },
    );
  }
}
