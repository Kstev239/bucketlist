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

//  void timer(context){
//    Timer(Duration(seconds: 2), (){
//      if(_auth.currentUser() != null){
//        getCurrentUser(context);
//      }else{
//        Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
//      }
//    });
//
//  }

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
