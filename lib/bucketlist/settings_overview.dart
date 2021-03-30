import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bucket_list/bucketlist/change_priority.dart';
import 'package:the_bucket_list/bucketlist/update_date.dart';
import 'update_picture.dart';
import 'update_bucketname.dart';

class SettingsOverview extends StatefulWidget {
  SettingsOverview({this.userMail, this.loggedInUser, this.docId});
  final String loggedInUser;
  final String docId;
  final String userMail;
  @override
  _SettingsOverviewState createState() => _SettingsOverviewState();
}

class _SettingsOverviewState extends State<SettingsOverview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff032e42),
          title: Text("Einstellungen"),
        ),
        body: Container(
          color: Color(0xff9cacbf),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff012e67)),
                  child: ListTile(
                    title: Text(
                      "Name ändern",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateName(
                                    loggedInUser: widget.loggedInUser,
                                    docId: widget.docId,
                                    userMail: widget.userMail,
                                  )));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff012e67)),
                  child: ListTile(
                    title: Text("Bild ändern",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePicture(
                                    loggedInUser: widget.loggedInUser,
                                    docId: widget.docId,
                                    userMail: widget.userMail,
                                  )));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff012e67)),
                  child: ListTile(
                    title: Text("Datum ändern",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateDate(
                            loggedInUser: widget.loggedInUser,
                            docId: widget.docId,
                            userMail: widget.userMail,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff012e67)),
                  child: ListTile(
                    title: Text("Priorität ändern",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePrio(
                            loggedInUser: widget.loggedInUser,
                            docId: widget.docId,
                            userMail: widget.userMail,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
