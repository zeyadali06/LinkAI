import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/profile/presentation/views/widgets/profile_view_body.dart';

import '../../../splash/presentation/manager/cubit/app_theme_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor:
            BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light
                ? Colors.white
                : const Color(0xff2a2a2a),
      ),
      body: const ProfileViewBody(),
    );
  }
}
