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
          backgroundColor: Color(0xff032e42),
          title: Text('Passwort zurücksetzen'),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xff9cacbf),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Bitte geben Sie Ihre E-Mail-Adresse ein um Ihr Passwort zurückzusetzen.",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
              ),
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
                    hintText: 'E-Mail-Adresse...',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                child: Text('Passwort zurücksetzen',
                style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                color: Color(0xff032e42),
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
          backgroundColor: Color(0xff032e42),
          title: Text('Ihr Passwort wurde zurückgesetzt.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('In den nächsten Minuten erhalten Sie eine Email.', style: TextStyle(color: Colors.white),),
                Text('Folgen Sie dem Link um Ihr Passwort zurückzusetzen.', style: TextStyle(color: Colors.white),),
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
