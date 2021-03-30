import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_bucket_list/motivation/motivation_container.dart';

class MotivationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Motivation'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Motivation').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitCircle(
                  color: Colors.blueAccent,
                  size: 70,
                ),
              );
            }
            final int motivationLength = snapshot.data.documents.length;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: motivationLength,
                    itemBuilder: (BuildContext context, int i) {
                      final DocumentSnapshot _motivation =
                          snapshot.data.documents[i];
                      return MotivationContainer(
                        text: _motivation['text'],
                        author: _motivation['autor'],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
