import 'package:flutter/cupertino.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("Setting",style: TextStyle(
            color: CupertinoColors.white
          ),),
        )
      ],
    );
  }
}
