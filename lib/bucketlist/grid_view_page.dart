import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'grid_container.dart';

class GridViewPage extends StatelessWidget {
  GridViewPage(
      {this.count, this.myDocCount, this.userEmail, this.loggedInUser});
  final String loggedInUser;
  final int count;
  final List<DocumentSnapshot> myDocCount;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff9cacbf)
        // gradient: LinearGradient(
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.topRight,
        //     colors: [Colors.yellow, Colors.red]),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(count, (index) {
          String gridName = myDocCount[index].data['name'];
          String docId = myDocCount[index].documentID;
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GridTile(
                child: GridContainer(
                  loggedInUser: loggedInUser,
                  name: gridName,
                  myDocCount: myDocCount,
                  index: index,
                  docId: docId,
                  userMail: userEmail,
            )),
          );
        }),
      ),
    );
  }
}
