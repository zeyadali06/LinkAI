import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/profile/presentation/views/widgets/custom_divider.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.hasArrow,
    this.borderRadius = BorderRadius.zero,
    this.description,
    this.isTitle = false,
    this.onPressed,
    this.maxDescriptionLines = 1,
    this.verticalPadding = 15,
    this.addDivider = false,
  });

  final String title;
  final bool hasArrow;
  final BorderRadiusGeometry borderRadius;
  final String? description;
  final String? subtitle;
  final bool isTitle;
  final GestureTapCallback? onPressed;
  final int maxDescriptionLines;
  final double verticalPadding;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 15, vertical: verticalPadding),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 7,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: isTitle
                              ? AppStyles.normal16(context, Colors.grey)
                              : AppStyles.normal18(context),
                        ),
                      ),
                    ),
                    if (subtitle != null)
                      Flexible(
                        flex: 2,
                        child: Text(
                          subtitle!,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.defaultStyle(context, Colors.grey),
                        ),
                      ),
                    if (hasArrow)
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).iconTheme.color, size: 16),
                  ],
                ),
                if (description != null)
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              description!,
                              maxLines: maxDescriptionLines,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppStyles.defaultStyle(context, Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (addDivider)
            Container(
              color: theme.cardColor,
              child: const CustomDivider(),
            ),
        ],
      ),
    );
  }
}
