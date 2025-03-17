import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/widgets/pin_code_field.dart';

class NewEmailPinBody extends StatefulWidget {
  const NewEmailPinBody({
    super.key,
    required this.controller,
    required this.email,
  });

  final TextEditingController controller;
  final TextEditingController email;

  @override
  State<NewEmailPinBody> createState() => _NewEmailPinBodyState();
}

class _NewEmailPinBodyState extends State<NewEmailPinBody> {
  int _resendTimer = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  void _startResendCountdown() {
    setState(() {
      _resendTimer = 30;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendOTP() {
    // TODO: Add OTP resend logic
    _startResendCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          Text(
            "Please enter the verification code we sent to",
            textAlign: TextAlign.center,
            style: AppStyles.defaultStyle(context),
          ),
          const SizedBox(height: 8),
          Text(
            widget.email.text,
            style: AppStyles.semiBold18(context),
          ),
          const SizedBox(height: 28),
          PinCodeField(
            inputFormatters: [Formatters.numbersOnlyFormatter],
            controller: widget.controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "OTP code is required";
              }
              if (value.length < 6) {
                return "OTP must be 6 digits";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: _canResend ? _resendOTP : null,
            child: Text(
              _canResend ? "Resend" : "Resend($_resendTimer)",
              style: AppStyles.defaultStyle(context, _canResend ? null : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
