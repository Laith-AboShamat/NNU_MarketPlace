
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../services/auth.dart';
import 'custom_icon_button.dart';

class SignUpButtons extends StatefulWidget {
  const SignUpButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpButtons> createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  Auth authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            User? user = await Auth.signInWithGoogle(context: context);
            if (user != null) {
              authService.getAdminCredentialPhoneNumber(context, user);
            }
          },
          child: CustomIconButton(
            text: 'Signup with Google',
            imageIcon: 'assets/google.png',
            bgColor: whiteColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
