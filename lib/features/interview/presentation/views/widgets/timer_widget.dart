import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void didChangeDependencies() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds += 1;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime() {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:' '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(),
      style: AppStyles.normal20(context, Colors.white),
    );
  }
}
