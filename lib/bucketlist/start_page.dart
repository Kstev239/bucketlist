import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bucket_list/bucketlist/stream_builder.dart';

class StartPage extends StatelessWidget {
  StartPage({@required this.userEmail, @required this.loggedInUser,});

  final loggedInUser;
  final userEmail;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff9cacbf)
        // gradient: LinearGradient(
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.topRight,
        //     colors: [Color(0xff9cacbf), Color(0xff032e42)]),
      ),
      child: Column(
        children: <Widget>[
          GetStream(loggedInUser: loggedInUser, userMail: userEmail,),
        ],
      ),
    );
  }
}
