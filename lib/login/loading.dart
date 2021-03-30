import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bucket_list/login/welcome_screen.dart';
import 'dart:async';
import '../bucketlist/home_page.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoadingPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String loggedInUser;
  String userEmail;

  /// Check if the user has already logged in on this device,
  /// if so redirect him to the homescreen, otherwise redirect
  /// him to the login screen
  void getCurrentUser(context) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        if(user.isEmailVerified){
        userEmail = user.email;
        loggedInUser = user.uid;
        if(userEmail != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              HomePage(userEmail: userEmail,
                loggedInUser: loggedInUser,)),
              );
        }
//          Navigator.pop(context);
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
        }
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser(context);
    return SafeArea(
      child: Center(
        child: Container(
          color: Colors.white,
          child: FlareActor(
            'assets/buck.flr',
            animation: 'teste',
          ),
        )
      ),
    );
  }
}
