import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/person_avatar.dart';
import 'package:linkai/features/profile/presentation/managers/profile_cubit/profile_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = UserModel.instance;
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.read<ProfileCubit>().pickImage(),
          child: Stack(
            alignment: Alignment.bottomRight, // Aligns the camera icon to bottom-right
            children: [
              PersonAvatar(
                imageURL: user.profileImage,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).iconTheme.color, // Background color of the icon
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
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.firstName?.toUpperCase() ?? "Guest",
                style: AppStyles.bold18(context),
              ),
              Row(
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        user.email ?? "No Email",
                        style: AppStyles.normal16(context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
