import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registration_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bucket_list/bucketlist/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'reset_pw.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool showSpinner = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  String password;
  String registEmail;
  String registPassword;
  String registPassword1;
  String wrongPw = '';
  String name;
  Color pwColor;
  String loggedInUser;
  String userEmail;
  Future getCurrentUser(context) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        if (user.isEmailVerified) {
          userEmail = user.email;
          loggedInUser = user.uid;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        userEmail: userEmail,
                        loggedInUser: loggedInUser,
                      )));
        } else {
          setState(() {
            hintText = 'Deine Email-Adresse wurde noch nicht verifiziert.';
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
  var pageIndex = 0;

  String hintText = '';
  Future verifyUser() async {
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
  void color(){
    if(registPassword.length < 6){
      setState(() {
        pwColor = Colors.red;
      });
    }else{
      setState(() {
        pwColor = Colors.green;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    double pad = MediaQuery.of(context).size.height/35;

    List<Widget> displayPage =[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login',
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            ),

            Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    height:
                    MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            hintText,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(pad),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                size: 30,
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType
                                      .emailAddress,
                                  textAlign: TextAlign.center,
                                  onChanged: (index) {
                                    email = index;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText:
                                    'Email-Adresse...',
                                    hintStyle: TextStyle(
                                        color: Colors.black),
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(pad),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  onChanged: (index) {
                                    password = index;
                                  },
                                  decoration: InputDecoration(
//                                    border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                                    ),
                                    filled: true,
                                    hintText: 'Passwort...',
                                    hintStyle: TextStyle(
                                        color: Colors.black),
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -25,
                  child: FlatButton(
                    onPressed: () async {
                      try {
                        final newUser = (await _auth
                            .signInWithEmailAndPassword(
                            email: email,
                            password: password))
                            .user;
                        getCurrentUser(context);
                        if (newUser != null) {
                        }
                      } catch (e) {
                        print(e);
                        setState(() {
                          hintText =
                          'Falsche Email und/oder Passwort';
                        });
                      }
                    },
                    child: Container(
                        height:
                        MediaQuery.of(context).size.height /
                            15,
                        width:
                        MediaQuery.of(context).size.width /
                            2,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(
                                  1,
                                  1
                                )
                              )
                            ],
                            borderRadius:
                            BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xff8dc6d9),
                                  Color(0xff2f8db3)
                                ])),
                        child: Center(
                            child: Text(
                              'Anmelden',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ))),
                  ),
                ),
              ],
            ),
          Container(
            child: FlatButton(
              child: Text(''),
              onPressed: () async{
                try {
                  final newUser = (await _auth
                          .signInWithEmailAndPassword(
                      email: email,
                      password: password))
                    .user;
                getCurrentUser(context);
                if (newUser != null) {
                }
                } catch (e) {
                print(e);
                setState(() {
                hintText =
                'Falsche Email und/oder Passwort';
                });
                }
              },
            ),
            height: MediaQuery.of(context).size.height /
                30,
            width: MediaQuery.of(context).size.width /
                2,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                },
                child: Text('Passwort vergessen?', style: TextStyle(color: Colors.blue, fontSize:18, decoration: TextDecoration.underline),),
              ),
            ),
          )
          ],
        ),
    ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Registrieren',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white )),
              ),
              Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      height:
                      MediaQuery.of(context).size.height / 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              wrongPw,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(pad),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.mail,
                                  size: 30,
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType
                                        .emailAddress,
                                    textAlign: TextAlign.center,
                                    onChanged: (index) {
                                      registEmail = index;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText:
                                      'Email-Adresse...',
                                      hintStyle: TextStyle(
                                          color: Colors.black),
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('Das Passwort muss mindestens 6 Zeichen lang sein.', textAlign: TextAlign.center, style: TextStyle(color: pwColor),),
                          Padding(
                            padding: EdgeInsets.only(bottom: pad, left: pad, right: pad),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.lock,
                                  size: 30,
                                ),
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    onChanged: (index) {
                                      registPassword = index;
                                      color();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Passwort...',
                                      hintStyle: TextStyle(
                                          color: Colors.black),
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(pad),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.lock,
                                  size: 30,
                                ),
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    onChanged: (index) {
                                      registPassword1 = index;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Passwort wiederholen...',
                                      hintStyle: TextStyle(
                                          color: Colors.black),
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -25,
                    child: FlatButton(
                      onPressed: () async {
                        SpinKitCircle(
                          color: Colors.blueAccent,
                          size: 70,
                        );
                        if(registPassword == registPassword1){
                          try {
                            final newUser = (await _auth.createUserWithEmailAndPassword(email: registEmail, password: registPassword)).user;
                            _information();
                            verifyUser();
                          } catch (e) {
                            print(e);
                          }
                        }else{
                          setState(() {
                            wrongPw = 'Das Passwort stimmt nicht überein.';
                          });
                        }
                      },
                      child: Container(
                          height:
                          MediaQuery.of(context).size.height /
                              15,
                          width:
                          MediaQuery.of(context).size.width /
                              2,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.yellow,
                                    Colors.red
                                  ]),
                              boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(
                                  1,
                                  1
                              )
                            ),
                              ]
                          ),
                          child: Center(
                              child: Text(
                                'Registrieren',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/2,
                child: FlatButton(
                  child: Text(''),
                  onPressed: () async {
                    SpinKitCircle(
                    color: Colors.blueAccent,
                    size: 70,
                    );
                    if(registPassword == registPassword1){
                    try {
                    final newUser = (await _auth.createUserWithEmailAndPassword(email: registEmail, password: registPassword)).user;
                    _information();
                    verifyUser();
                    } catch (e) {
                    print(e);
                    }
                    }else{
                    setState(() {
                    wrongPw = 'Das Passwort stimmt nicht überein.';
                    });
                    }
                    },
                ),
              ),
              SizedBox(
                height: 50
              )
            ],
          ),
        ),
      )
    ];

    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xff032e42)
              // gradient: LinearGradient(
              //     begin: Alignment.bottomLeft,
              //     end: Alignment.topRight,
              //     colors: [Colors.yellow, Colors.red]),
            ),
            child: ListView(
              children: <Widget>[
                Column(
//              mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                        'assets/bali.png',
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'Buckify',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.balooBhaina(fontSize: 32, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleSwitch(
                          initialLabelIndex: 0,
                          minWidth: 90.0,
                          cornerRadius: 20,
                          activeBgColor: Colors.green,
                          activeTextColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveTextColor: Colors.white,
                          labels: ['Anmelden', 'Registrieren'],
                          icons: [Icons.home, Icons.add_circle_outline],
                          activeColors: [Colors.green, Colors.blue],
                          onToggle: (index) {
                            setState(() {
                              pageIndex = index;
                            });
                          }),
                    ),
                    displayPage[pageIndex],
                  ],
                ),
              ],
            ),
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
                Text('An die angegebene Email-Adresse wurde ein Bestätigungslink geschickt.', style: TextStyle(color: Colors.white),),
                Text('Bestätige deine Email-Adresse durch klicken des Bestätigungslinks.', style: TextStyle(color: Colors.white),),
                Text('Im Anschluss kannst du dich mit den Anmeldedaten einloggen.', style: TextStyle(color: Colors.white),),
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
