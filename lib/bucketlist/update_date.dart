import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'home_page.dart';
class UpdateDate extends StatefulWidget {
  UpdateDate({this.loggedInUser, this.docId, this.userMail});
  final String loggedInUser;
  final String docId;
  final String userMail;
  @override
  _UpdateDateState createState() => _UpdateDateState();
}

class _UpdateDateState extends State<UpdateDate> {
  var _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_currentDate != null) {
              await Firestore.instance
                  .collection('Buckets')
                  .document('${widget.loggedInUser}')
                  .collection('User')
                  .document(widget.docId)
                  .updateData({"date": _currentDate});
            }else{

            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        userEmail: widget.userMail,
                        loggedInUser: widget.loggedInUser)));
          },
          label: Text("Datum ändern"),
          icon: Icon(Icons.camera,
            size: 30,),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff032e42),
          title: Text(
            "Datum ändern",
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
                  "Wählen Sie ein neues Datum für Ihren Bucket aus",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CalendarCarousel(
                        headerTitleTouchable: true,
                        headerTextStyle: TextStyle(color: Color(0xff032e42),
                            fontWeight: FontWeight.bold, fontSize: 22),
                        maxSelectedDate: DateTime(DateTime.now().year + 50, DateTime.now().month, DateTime.now().day),
                        onDayPressed:
                            (DateTime date, List events) {
                          setState(() {
                            _currentDate = date;
                          });
                        },
                        weekdayTextStyle:
                        TextStyle(color: Colors.black),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                        ),
                        iconColor: Color(0xff032e42),
                        thisMonthDayBorderColor: Colors.grey,
                        weekFormat: false,
//                                height: 400.0,
                        selectedDateTime: _currentDate,
                        daysHaveCircularBorder: true,
                      ),
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
