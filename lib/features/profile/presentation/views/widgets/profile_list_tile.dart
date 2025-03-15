import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class ProfileListTile extends StatelessWidget {
  ProfileListTile(
      {super.key,
      required this.title,
      this.subtitle,
      required this.hasArrow,
      required this.height,
       this.borderRadius= BorderRadius.zero,
      this.description,
      this.isTitle = false,
      this.borderStyle,this.onPressed});

  final String title;
  final bool hasArrow;
   BorderRadiusGeometry borderRadius;
  final double height;
  String? description;
  String? subtitle;
  bool isTitle;
  BoxBorder? borderStyle;
  GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return GestureDetector(

      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: media.width * .9,
        height: height,
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: borderRadius,
            border: borderStyle ?? const Border()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: isTitle
                        ? AppStyles.normal16(context, Colors.white)
                            .copyWith(color: Colors.grey)
                        : AppStyles.normal18(context, Colors.white)),
                const Spacer(),
                if (subtitle != null)
                  Text(subtitle!, style: AppStyles.normal16(context, Colors.grey).copyWith(fontSize: 14)),
                const SizedBox(width: 7),
                if (hasArrow)
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
              ],
            ),
            if (description != null)
              Text(description!, style: AppStyles.normal16(context, Colors.grey).copyWith(fontSize: 14))
          ],
        ),
      ),
    );
  }
}
