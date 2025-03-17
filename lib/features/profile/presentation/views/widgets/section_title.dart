import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.color = Colors.grey,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: AppStyles.bold14(context, Colors.grey)),
    );
  }
}
