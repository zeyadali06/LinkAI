import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed, this.minWidth = 0});

  final void Function() onPressed;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color(0xff6d50ea),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.grey.withValues(alpha: .20),
        highlightColor: Colors.grey.withValues(alpha: .20),
        child: const Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
      ),
    );
  }
}
