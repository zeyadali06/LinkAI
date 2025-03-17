import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';

class ScoreView extends StatelessWidget {
  const ScoreView(this.score, {super.key});

  final ScoreModel score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Score",
          style: AppStyles.semiBold18(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(
                "Score: ${score.score.toString()}%",
                style: AppStyles.normal16(context),
              ),
              Text(
                "Summary: ${score.summary.toString()}",
                style: AppStyles.normal16(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
