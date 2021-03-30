import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_bucket_list/bucketlist/bucket_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:http/http.dart';
//import 'dart:convert';
class GetStream extends StatefulWidget {
  GetStream({this.loggedInUser,});
  final String loggedInUser;
  @override
  _GetStreamState createState() => _GetStreamState();
}

class _GetStreamState extends State<GetStream> {
  Stream _stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _stream = Firestore.instance
      .collection('Buckets')
      .document(widget.loggedInUser)
      .collection('User')
      .orderBy('time', descending: true)
      .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitCircle(
                color: Colors.blueAccent,
                size: 70,
              ),
            );
          }
          final int bucketLength = snapshot.data.documents.length;
          return Expanded(
            child: ListView.builder(
                itemCount: bucketLength,
                itemBuilder: (BuildContext context, int i) {
                  final DocumentSnapshot _bucket = snapshot.data.documents[i];
//                  picture(_bucket['url']);
//                  print(bucketPicture);
                  return BucketContainer(
                          name: _bucket['name'],
                          activity: _bucket['activity'],
                          priority: _bucket['priority'],
                          budget: _bucket['budget'],
                          docId: _bucket.documentID,
                          userId: widget.loggedInUser,
                          bucketStatus: _bucket['status'],
                          date: _bucket['date'],
                          picture: _bucket['url'],
                          message: _bucket['infos'],
                        );
                    },
                  ));
                },
            );
        }
  }
