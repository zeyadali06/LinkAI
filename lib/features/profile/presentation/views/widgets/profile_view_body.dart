import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/profile/presentation/managers/profile_cubit/profile_cubit.dart';
import 'package:linkai/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:linkai/features/profile/presentation/views/widgets/profile_list_tile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = UserModel.instance;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileImagePicked) {
          showSnackBar(context, "Image picked successfully", backgroundColor: Colors.green);
        }
        if (state is ProfileImageError) {
          showSnackBar(context, "Couldn't pick image", backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ProfileLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // ignore: prefer_const_constructors
                  ProfileHeader(),
                  const SizedBox(height: 20),
                  ProfileListTile(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.changeName, extra: context.read<ProfileCubit>());
                    },
                    title: "Name",
                    subtitle: user.firstName ?? "Guest",
                    hasArrow: true,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  const SizedBox(height: 20),
                  const ProfileListTile(
                    isTitle: true,
                    title: "Account security",
                    hasArrow: false,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  ),
                  ProfileListTile(
                    onPressed: () => GoRouter.of(context).push(AppRouter.changeEmail),
                    title: "Email",
                    hasArrow: true,
                    addDivider: true,
                    subtitle: user.email ?? "No Email",
                  ),
                  ProfileListTile(
                    onPressed: () => GoRouter.of(context).push(AppRouter.changePassword),
                    title: "Password",
                    hasArrow: true,
                    addDivider: true,
                    description: "Set a permanent password to login to your account",
                    maxDescriptionLines: 2,
                    borderRadius: const BorderRadius.all(Radius.zero),
                  ),
                  const ProfileListTile(
                    title: "Log out of all devices",
                    hasArrow: true,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  ),
                  const SizedBox(height: 20),
                  ProfileListTile(
                    title: "Log out",
                    hasArrow: true,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () async => await onTapLogout(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<T?> onTapLogout<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Log out",
          style: AppStyles.normal18(context),
        ),
        content: Text(
          "Are you sure you want to log out?",
          style: AppStyles.defaultStyle(context),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: Text(
              "No",
              style: AppStyles.defaultStyle(context),
            ),
          ),
          TextButton(
            onPressed: () async {
              const FlutterSecureStorage storage = FlutterSecureStorage();
              await storage.delete(key: 'user_token');
              if (context.mounted) {
                GoRouter.of(context).pop();
                GoRouter.of(context).go(AppRouter.loginView);
              }
            },
            child: Text(
              "Yes",
              style: AppStyles.defaultStyle(context, Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
