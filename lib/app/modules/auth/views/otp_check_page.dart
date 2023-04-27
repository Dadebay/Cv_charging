import 'package:cv_charing/app/constants/constants.dart';
import 'package:cv_charing/app/constants/text_fields/phone_number.dart';
import 'package:flutter/material.dart';

class OtpCheck extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor3,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logo),
          PhoneNumber(mineFocus: focusNode, controller: textEditingController, requestFocus: focusNode, style: false),
          ElevatedButton(onPressed: () {}, child: Text('otp agree')),
        ],
      ),
    );
  }
}
