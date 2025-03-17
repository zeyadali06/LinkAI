import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';

import '../../../../splash/presentation/manager/cubit/app_theme_cubit.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final themeCubit = context.read<AppThemeCubit>();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),

                ),

                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Text("Theme",
                          style:AppStyles.normal16(context).copyWith(
                            fontSize: 14
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildThemeOption(
                          context,
                          title: "Light",
                          themeMode: ThemeMode.light,
                          icon: Icons.light_mode,
                          isSelected: themeCubit.appTheme == ThemeMode.light,
                          onTap: () => themeCubit.changeTheme(ThemeMode.light),
                        ),
                        _buildThemeOption(
                          context,
                          title: "Dark",
                          themeMode: ThemeMode.dark,
                          icon: Icons.dark_mode,
                          isSelected: themeCubit.appTheme == ThemeMode.dark,
                          onTap: () => themeCubit.changeTheme(ThemeMode.dark),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required ThemeMode themeMode,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
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
              border: Border.all(
                color: isSelected ? Colors.purple : Colors.transparent,
                width: 2,
              ),
            ),
            child:
                Icon(icon, size: 30, color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
