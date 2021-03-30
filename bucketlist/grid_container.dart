import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bucket_info_page.dart';
class GridContainer extends StatelessWidget {
  GridContainer({this.name, this.myDocCount, this.index, this.loggedInUser, this.docId,});

  final String docId;
  final String loggedInUser;
  final String name;
  final List<DocumentSnapshot> myDocCount;
  final index;

  @override
  Widget build(BuildContext context) {
    String gridActivity = myDocCount[index].data['activity'];
    String gridBudget = myDocCount[index].data['budget'];
    var gridDate = myDocCount[index].data['date'];
    String gridPicture = myDocCount[index].data['url'];
    String gridPriority = myDocCount[index].data['priority'];
    var bucketColors = [Colors.black, Colors.blueGrey];
    String bucketDone = '';

    if(myDocCount[index].data['status'] == 'true'){
        bucketColors = [Colors.tealAccent, Colors.green[900]];
        bucketDone = 'Erledigt';
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BucketInfoPage(name: name,
          activity: gridActivity, priority: gridPriority, budget: gridBudget, userId: loggedInUser, date: gridDate, docId: docId,picture: gridPicture,)));
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: bucketColors
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(bucketDone, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
