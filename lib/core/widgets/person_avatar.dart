import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({super.key, this.radius = 20});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: radius,
      child: Icon(
        Icons.person,
        color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.white : Theme.of(context).iconTheme.color,
      ),
    );
  }
}
