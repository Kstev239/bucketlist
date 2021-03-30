import 'package:flutter/material.dart';
import 'changeEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bucket_list/main.dart';
import 'package:the_bucket_list/login/reset_pw.dart';
class Settings extends StatelessWidget {
  Settings({this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Einstellungen'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(title: Text('Email-Adresse ändern', style: TextStyle(color:Colors.white),),
                  leading: Icon(Icons.mail, size: 30, color: Colors.white,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeEmail()));
                },),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(title: Text('Passwort ändern', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.lock, color: Colors.white, size: 30,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()
                  ));
                },),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  title: Text('Account löschen', style: TextStyle(color: Colors.white),)
                  , leading: Icon(Icons.delete, color: Colors.white, size: 30,),
                onTap: (){
                  deleteAccount(context, email);
                },),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.info, color: Colors.white, size: 30,),
                  title: Text('Mehr Informationen', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    showAboutDialog(
                      context: context,
                      applicationVersion: '2',
                      applicationLegalese: 'Lizensen der Applicaiton',
                      applicationName: 'Buckify',
                    );
                  },),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future deleteAccount(context, String email,) async {
    String password2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account löschen?'),
          content: Expanded(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Passwort eingeben...'
              ),
              onChanged: (index){
                password2 = index;
              },
            ),
          ),
          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                width: double.infinity,
//                height: 20,
//                child: TextField(
//                  obscureText: true,
//                  decoration: InputDecoration(
//                    hintText: 'Password...'
//                  ),
//                  onChanged: (index){
//                    password = index;
//                  },
//                ),
//              ),
//            ),
            FlatButton(
              child: Text('Ja!'),
              onPressed: () async{
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                AuthCredential credentials = EmailAuthProvider.getCredential(email: email, password: password2);
                AuthResult result = await user.reauthenticateWithCredential(credentials);
                await result.user.delete();
//                await Firestore.instance.collection('User').document(user.uid).collection('myChats').document().delete();
//                await Firestore.instance.collection('User').document(user.uid).collection('myPosts').document().delete();
//                await Firestore.instance.collection('Posts').document(location).collection('feed')
//                    .where('postUser', isEqualTo: user.uid).snapshots().listen((event)=> event.documents.forEach((doc)=> doc.documentID));
//                await Firestore.instance.collection('User').document(user.uid).delete();
                FirebaseAuth.instance.signOut();
//                user.delete();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp()));
              },
            ),
            FlatButton(
              child: Text('Nein!'),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
