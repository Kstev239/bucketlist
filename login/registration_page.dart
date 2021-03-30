import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
class RegistrationPage extends StatefulWidget {

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email;

  String password;

  String password2;

  String loggedInUser;

  String userEmail;

  String wrongPw = '';

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        await user.sendEmailVerification();
        userEmail = user.email;
        loggedInUser = user.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registrieren'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.yellow, Colors.red]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(wrongPw, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
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
              Text('Das Passwort muss mindestens 6 Zeichen lang sein.', style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (index){
                    password = index;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    hintText: 'Passwort...',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (index){
                    password2 = index;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    hintText: 'Passwort Wiederholen...',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  color: Colors.red,
                  child: Text('Registrieren'),
                  onPressed: () async{
                    if(password == password2){
                    try {
                      final newUser = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
                      _information();
                      getCurrentUser();
                      if (newUser != null){
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(userEmail: userEmail,
//                          loggedInUser: loggedInUser,)));
                      }
                    }
                    catch(e){}
                  }else{
                      setState(() {
                        wrongPw = 'Das Passwort stimmt nicht überein.';
                      });
                      }
                  }
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
          title: Text('Bestätigung der Email-Adresse', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An die angegebene Email-Adresse ein Bestätigungslink geschickt.', style: TextStyle(color: Colors.white),),
                Text('Bestätige deine Email-Adresse durch klicken des Bestätigungslinks.', style: TextStyle(color: Colors.white),),
                Text('Im Anschluss kannst du dich mit den Anmeldedaten einloggen.', style: TextStyle(color: Colors.white),),
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