import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_assets.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/features/splash/presentation/manager/auto_login_cubit/auto_login_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with TickerProviderStateMixin {
  late AnimationController _controller;
  StreamSubscription? _authSubscription;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkLoginState();
      }
    });
  }

  void _checkLoginState() {
    _authSubscription = context.read<AutoLoginCubit>().stream.listen((state) {
      if (state is AutoLoginSuccess) {
        if (mounted) {
          GoRouter.of(context).go(AppRouter.navigatorView);
        }
      } else if (state is AutoLoginFailure) {
        if (mounted) {
          GoRouter.of(context).go(AppRouter.loginView);
        }
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Lottie.asset(
          Assets.animationsLogo,
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
