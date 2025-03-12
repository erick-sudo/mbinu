import 'package:flutter/material.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({
    super.key,
    required this.otpController1,
    required this.otpController2,
    required this.otpController3,
    required this.otpController4,
  });

  final TextEditingController otpController1;
  final TextEditingController otpController2;
  final TextEditingController otpController3;
  final TextEditingController otpController4;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 60, width: 60, child: TextFormField()),
        ],
      ),
    );
  }
}
