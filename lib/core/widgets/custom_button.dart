import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height = 55,
  });

  final void Function()? onPressed;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.grey.withValues(alpha: .20),
        highlightColor: Colors.grey.withValues(alpha: .20),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ),
    );
  }
}
