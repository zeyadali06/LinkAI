import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/enums/role_enum.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';

class RoleViewBody extends StatefulWidget {
  const RoleViewBody({super.key});

  @override
  State<RoleViewBody> createState() => _RoleViewBodyState();
}

class _RoleViewBodyState extends State<RoleViewBody> {
  @override
  void initState() {
    super.initState();
    ServiceLocator.getIt<AuthModel>().role = Role.user;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Text(
                  "Choose according to your interests",
                  style: AppStyles.normal18(context),
                ),
                const Expanded(child: SizedBox(height: 25)),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12), //
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Text(
                          "Role",
                          style: AppStyles.normal16(context), //
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildThemeOption(
                            context,
                            title: "User",
                            icon: Icons.person,
                            isSelected: ServiceLocator.getIt<AuthModel>().role == Role.user,
                            onTap: () {
                              ServiceLocator.getIt<AuthModel>().role = Role.user;
                              setState(() {});
                            },
                          ),
                          _buildThemeOption(
                            context,
                            title: "HR",
                            icon: Icons.business,
                            isSelected: ServiceLocator.getIt<AuthModel>().role == Role.hr,
                            onTap: () {
                              ServiceLocator.getIt<AuthModel>().role = Role.hr;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox(height: 25)),
                CustomButton(
                  text: "Continue",
                  onPressed: () async {
                    if (ServiceLocator.getIt<AuthModel>().role != null) {
                      GoRouter.of(context).push(AppRouter.phoneNumberView);
                    } else {
                      showSnackBar(context, "Please select a role");
                    }
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required final String title,
    required final IconData icon,
    required final bool isSelected,
    required final void Function() onTap, //
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? Colors.purple : Colors.transparent, width: 2),
            ),
            child: Icon(icon, size: 30, color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(height: 8),
          Text(title, style: AppStyles.defaultStyle(context)),
        ],
      ),
    );
  }
}
