import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class JobTag extends StatelessWidget {
  final String text;

  const JobTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.grey[200] : Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppStyles.bold14(context),
      ),
    );
  }
}
