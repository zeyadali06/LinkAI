import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/companies/presentation/views/user_companies_view/all_companies_view.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/home_view.dart';

import '../../../profile/presentation/managers/profile_cubit/profile_cubit.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../../splash/presentation/manager/cubit/app_theme_cubit.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({super.key});

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [


    BlocProvider(
      create: (context) =>
      JobsCubit()
        ..getJobs(),
      child: const HomeView(),
    ),
    const AllCompaniesView(),
    BlocProvider(
      create: (context) => ProfileCubit(),
      child: const ProfileView(),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            JobsCubit()
              ..getJobs(),
          ),
        ],
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: _screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Companies',
                ),
                BottomNavigationBarItem(
                  //TODo add user image
                  icon: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: BlocProvider
                          .of<AppThemeCubit>(context)
                          .appTheme ==
                          ThemeMode.light
                          ? Colors.white
                          : Theme
                          .of(context)
                          .iconTheme
                          .color,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
            )));
  }
}
