import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_assets.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.width = 50});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesSpalsh,
      width: width,
      height: width,
    );
  }
}
