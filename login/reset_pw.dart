import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  Future<void> resetPassword(String email, context) async {
    await _auth.sendPasswordResetEmail(email: email);
    _information();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Passwort zurücksetzen'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (index){
                    email = index;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    hintText: 'Email-Adresse...',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                child: Text('Passwort zurücksetzen'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                color: Colors.blue,
                onPressed: () async{
                  resetPassword(email, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _information() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: Colors.blue[300],
          title: Text('Dein Passwort wurde zurück gesetzt.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('In den nächsten Minuten erhältst du eine Email.', style: TextStyle(color: Colors.white),),
                Text('Folge dem Link um dein Passwort zurückzusetzen.', style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Dies kann einige Minuten in Anspruch nehmen.', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Schließen', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}
