import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
class UpdateName extends StatefulWidget {
  UpdateName({this.loggedInUser, this.docId, this.userMail});
  final String loggedInUser;
  final String docId;
  final String userMail;
  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  String newName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (newName != null) {
              await Firestore.instance
                  .collection('Buckets')
                  .document('${widget.loggedInUser}')
                  .collection('User')
                  .document(widget.docId)
                  .updateData({"name": newName});
            }else{

            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        userEmail: widget.userMail,
                        loggedInUser: widget.loggedInUser)));
          },
          label: Text("Namen ändern"),
          icon: Icon(Icons.camera,
            size: 30,),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff032e42),
          title: Text(
            "Namen ändern",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
            color: Color(0xffcacbf),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Geben Sie einen neuen Namen für Ihren Bucket ein",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (index) {
                      newName = index;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      hintText: 'Neuen Bucketnamen eingeben...',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
