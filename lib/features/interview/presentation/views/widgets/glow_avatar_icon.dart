import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowAvatarIcon extends StatefulWidget {
  const GlowAvatarIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 55,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.black,
  });

  final Future<void> Function(bool enabled)? onPressed;
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  State<GlowAvatarIcon> createState() => _GlowAvatarIconState();
}

class _GlowAvatarIconState extends State<GlowAvatarIcon> {
  late bool enabled;

  @override
  void initState() {
    enabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        enabled = !enabled;
        setState(() {});
        await widget.onPressed?.call(enabled);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: AvatarGlow(
          repeat: true,
          animate: enabled,
          glowRadiusFactor: .5,
          glowColor: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(widget.icon, color: widget.iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
