import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/pin_code_field.dart';

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
    return Container(
      color: AppColors.darkBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          children: [
            Text(
              "Please enter the verification code we sent to",
              style: AppStyles.normal16(context, Colors.white)
                  .copyWith(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email.text,
              style: AppStyles.semiBold18(context, Colors.white),
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
                style: AppStyles.normal16(
                    context, _canResend ? Colors.white : Colors.grey).copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
