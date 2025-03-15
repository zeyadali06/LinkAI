import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_colors.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/profile/presentation/views/widgets/profile_list_tile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../managers/profile_cubit/profile_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.instance;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileImagePicked) {
          showSnackBar(context, "Image picked successfully",
              backgroundColor: Colors.green);
        }
        if (state is ProfileImageError) {
          showSnackBar(context, "Couldn't pick image",
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ProfileLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.read<ProfileCubit>().pickImage(),
                        child: Stack(
                          alignment: Alignment.bottomRight, // Aligns the camera icon to bottom-right
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 35,
                              backgroundImage: user.profileImage != null
                                  ? NetworkImage(user.profileImage!)
                                  : const AssetImage("assets/images/default_profile.png") as ImageProvider,
                            ),
                            Positioned(
                              bottom: -1,
                              right: -1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.darkBackgroundColor, // Background color of the icon
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black, width: 1), // Optional white border
                                ),
                                padding: const EdgeInsets.all(4), // Adjust padding for icon size
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )

                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.firstName?.toUpperCase() ?? "Guest",
                              style: AppStyles.bold18(context, Colors.white)),
                          Text(user.email ?? "No Email",
                              style: AppStyles.normal16(context, Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileListTile(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.changeName,
                          extra: context.read<ProfileCubit>());
                    },
                    title: "Name",
                    subtitle: user.firstName ?? "Guest",
                    hasArrow: true,
                    height: 60,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  const SizedBox(height: 30),
                  ProfileListTile(
                    isTitle: true,
                    title: "Account security",
                    hasArrow: false,
                    height: 50,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  ProfileListTile(
                    onPressed: () =>
                        GoRouter.of(context).push(AppRouter.changeEmail),
                    title: "Email",
                    hasArrow: true,
                    subtitle: user.email ?? "No Email",
                    height: 80,
                    borderStyle: const Border(
                        bottom: BorderSide(color: Color(0xFF3B3B3B), width: 1)),
                  ),
                  ProfileListTile(
                    onPressed: () =>
                        GoRouter.of(context).push(AppRouter.changePassword),
                    title: "Password",
                    hasArrow: true,
                    description:
                        "Set a permanent password to login to your account",
                    height: 120,
                    borderRadius: const BorderRadius.all(Radius.zero),
                    borderStyle: const Border(
                        bottom: BorderSide(color: Color(0xFF3B3B3B), width: 1)),
                  ),
                  ProfileListTile(
                    title: "Log out of all devices",
                    hasArrow: true,
                    height: 80,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: ProfileListTile(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppColors.darkBackgroundColor,
                              title: const Text(
                                "Log out",
                                style: TextStyle(color: Colors.white),
                              ),
                              content: const Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              actions: [
                                TextButton(
                                  onPressed: () => GoRouter.of(context).pop(),
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    const storage = FlutterSecureStorage();
                                    await storage.delete(key: 'user_token');
                                    GoRouter.of(context).pop();
                                    GoRouter.of(context)
                                        .go(AppRouter.loginView);
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        title: "Log out",
                        hasArrow: true,
                        height: 60,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
