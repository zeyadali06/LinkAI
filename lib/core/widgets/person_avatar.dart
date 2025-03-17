import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/features/splash/presentation/manager/cubit/app_theme_cubit.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({super.key, this.radius = 35, this.imageURL});

  final double radius;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.dark ? Colors.black : Colors.black.withValues(alpha: .6),
      radius: radius,
      backgroundImage: imageURL != null ? NetworkImage(imageURL!) : null,
      child: imageURL == null
          ? Icon(
              Icons.person,
              size: radius * 1.5,
              color: BlocProvider.of<AppThemeCubit>(context).appTheme == ThemeMode.light ? Colors.white : Theme.of(context).iconTheme.color,
            )
          : null,
    );
  }
}
