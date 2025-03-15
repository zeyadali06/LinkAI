import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

class Logo extends StatefulWidget {
  const Logo({
    super.key,
    this.width = 50,
    this.animate = true,
  });

  final double width;
  final bool animate;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.animationsLogo,
      width: widget.width,
      height: widget.width,
      animate: widget.animate,
      onLoaded: (composition) {
        if (widget.animate) {
          _controller
            ..duration = composition.duration
            ..forward();
        }
      },
    );
  }
}
