import 'package:flutter/material.dart';
import 'package:linkai/features/profile/presentation/views/widgets/profile_list_tile.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/app_styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.firstName!.toUpperCase(),
                        style: AppStyles.bold18(context, Colors.white)),
                    Text(user.email!,
                        style: AppStyles.normal16(context, Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ProfileListTile(
              title: "Name",
              subtitle: user.firstName!,
              hasArrow: true,
              height: 60,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileListTile(
                isTitle: true,
                title: "Account security",
                hasArrow: false,
                height: 50,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            ProfileListTile(
              title: "Email",
              hasArrow: true,
              subtitle: user.email!,
              height: 80,
              borderStyle: const Border(
                  bottom: BorderSide(color: Color(0xFF3B3B3B), width: 1)),
            ),

            ProfileListTile(
              title: "Password",
              hasArrow: true,
              description: "Set a permanent password to login to your account",
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
                  title: "Log out",
                  hasArrow: true,
                  height: 60,
                  borderRadius: BorderRadius.circular(16)),
            ),
          ],
        ),
      ),
    );
  }
}
