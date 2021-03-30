import 'package:flutter/material.dart';
import 'bucket_info_page.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:loading_animations/loading_animations.dart';
class BucketContainer extends StatelessWidget {

  BucketContainer({this.name, this.activity, this.budget, this.priority, this.docId, this.userId, this.bucketStatus, this.date, this.picture, this.message});
  final String activity;
  final String name;
  final String priority;
  final String budget;
  final String docId;
  final String userId;
  final bucketStatus;
  final date;
  final picture;
  final message;
  @override
//  String bucketPicture;
//  Future getPicture(name) async{
//    Response response = await get('https://pixabay.com/api/?key=16084571-ece772a43c16adc1643e9a33e&q=$name&image_type=photo');
//    String data = response.body;
//    if(response.statusCode == 200){
//      bucketPicture = jsonDecode(data)['hits'][0]['webformatURL'];
//      return bucketPicture;
//    }
//  }
  Widget build(BuildContext context) {
//    getPicture(picture);

    var bucketColors = [Colors.black, Colors.blueGrey];
    String bucketDone = '';
    if(bucketStatus == 'true'){
      bucketColors = [Colors.tealAccent, Colors.green[900]];
      bucketDone = 'Erledigt';
    }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BucketInfoPage(name: name,
                activity: activity, priority: priority, budget: budget, docId: docId, userId: userId, date: date, picture: picture, message: message,)));
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: bucketColors,
                  )
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
//                      child: Image.asset(bucketActivity)),
                          child: Image.network(picture)),
                    ),
//                Text(activity, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),),
                    Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23), textAlign: TextAlign.center,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(bucketDone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
//      },
//    );
  }
}
