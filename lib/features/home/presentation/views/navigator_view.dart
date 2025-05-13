import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/enums/role_enum.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/person_avatar.dart';
import 'package:linkai/features/companies/presentation/views/user_companies_view/all_companies_view.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:linkai/features/home/presentation/views/home_view.dart';
import '../../../profile/domain/useCases/addProfileImageUseCase/add_profile_image.dart';
import '../../../profile/presentation/managers/profile_cubit/profile_cubit.dart';
import '../../../profile/presentation/views/profile_view.dart';

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
      create: (context) => JobsCubit()..getJobs(),
      child: const HomeView(),
    ),
    if (UserModel.instance.role == Role.hr) const AllCompaniesView(),
    const ProfileView(),
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
          create: (context) => JobsCubit()..getJobs(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(ServiceLocator.getIt<AddProfileImageUseCase>()),
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
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Theme.of(context).iconTheme.color,
          selectedLabelStyle: AppStyles.defaultStyle(context).copyWith(fontSize: 12),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            if (UserModel.instance.role == Role.hr)
              const BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Companies',
              ),
            BottomNavigationBarItem(
              icon: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return PersonAvatar(radius: 15, imageURL: UserModel.instance.profileImage);
                },
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
