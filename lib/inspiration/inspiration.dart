import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'inspiration_container.dart';

class InspirationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff9cacbf),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Beliebte Buckets'),
          backgroundColor: Color(0xff032e42),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Inspiration').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.blueAccent,
                    size: 70,
                  ),
                );
              }
              final int inspirationLength = snapshot.data.documents.length;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: inspirationLength,
                        itemBuilder: (BuildContext context, int i) {
                          final DocumentSnapshot _inspiration =
                              snapshot.data.documents[i];
                          return InspirationContainer(
                            title: _inspiration['title'],
                            activity: _inspiration['activity'],
                            picture: _inspiration['picture'],
                            link: _inspiration['link'],
                            text: _inspiration['text'],
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
