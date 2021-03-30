import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bucket_list/login/welcome_screen.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  String newEmail;
  Future getUser(context) async{
    try{
     final user = await FirebaseAuth.instance.currentUser();
       if(newEmail!=null){
         if(user!= null){
           user.updateEmail(newEmail);
     }
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
     }
    }
     catch(e){
      print(e);
     }
  }
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff9cacbf),
        appBar: AppBar(
          backgroundColor: Color(0xf032e42),
          title: Text('Email-Adresse ändern'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType
                      .emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (index) {
                    newEmail = index;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText:
                    'Neue Email-Adresse',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: (){
                    getUser(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff032e42)
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Email Adresse ändern',
                        style: TextStyle(color: Colors.white),),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
