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
        )
      ),
      body:  const ProfileViewBody(),
    );
  }
}
