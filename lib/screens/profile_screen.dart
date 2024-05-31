import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../services/user.dart';
import 'welcome_screen.dart';


class ProfileScreen extends StatefulWidget {
  static const screenId = 'profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserService firebaseUser = UserService();

  String? name;
  String? email;
  String? address;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var userData = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).
      get();
      if (userData.exists) {
        setState(() {
          name = userData.data()?['name'];
          email = userData.data()?['email'];
          address = userData.data()?['address'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: secondaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (name != null) ...[
              Text('Name: $name', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
            ],
            if (email != null) ...[
              Text('Email: $email', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
            ],
            if (address != null) ...[
              Text('Address: $address', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(secondaryColor),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                ),
              ),
              onPressed: () async {
                loadingDialogBox(context, 'Signing Out');
                Navigator.of(context).pop();
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WelcomeScreen.screenId, (route) => false);
                });
              },
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}