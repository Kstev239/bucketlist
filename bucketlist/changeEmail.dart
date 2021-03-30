import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
         Navigator.pop(context);
     }
    }
     catch(e){
      print(e);
     }
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            FlatButton(
              onPressed: (){
                getUser(context);
              },
              child: Text('Email Adresse ändern'),
            )
          ],
        ),
      ),
    );
  }
}
