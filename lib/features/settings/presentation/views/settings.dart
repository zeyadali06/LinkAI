import 'package:flutter/material.dart';
import 'package:linkai/features/settings/presentation/views/widgets/settings_body.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackgroundColor,
        title: Text("Settings",style: AppStyles.semiBold18(context,Colors.white),),
        centerTitle: true,

      ),
      body: const SettingsBody(),
    );
  }
}
