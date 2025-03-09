import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.width = 50});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.animationsLogo,
      width: width,
      height: width,
    );
  }
}
