import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/auth.dart';
import 'main_navigatiion_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String screenId = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Auth authService = Auth();
  @override
  void initState() {
    permissionBasedNavigationFunc();
    super.initState();
  }

  permissionBasedNavigationFunc() {
    Timer(const Duration(seconds: 15), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.screenId);
        } else {
          Navigator.pushReplacementNamed(
              context, MainNavigationScreen.screenId);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'NNU Marketplace',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  '',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/logo_gif.gif",
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
