import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/auth.dart';
import 'custom_icon_button.dart';

class LoginInButtons extends StatefulWidget {
  const LoginInButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginInButtons> createState() => _LoginInButtonsState();
}

class _LoginInButtonsState extends State<LoginInButtons> {
  Auth authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            User? user = await Auth.signInWithGoogle(context: context);
            if (user != null) {
              authService.getAdminCredentialPhoneNumber(context, user);
            }
          },
          child: CustomIconButton(
            text: 'Sign In with Google',
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
