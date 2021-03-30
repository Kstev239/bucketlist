import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'home_page.dart';
class UpdatePrio extends StatefulWidget {
  UpdatePrio({this.loggedInUser, this.docId, this.userMail});
  final String loggedInUser;
  final String docId;
  final String userMail;
  @override
  _UpdatePrioState createState() => _UpdatePrioState();
}

class _UpdatePrioState extends State<UpdatePrio> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_value != null) {
              await Firestore.instance
                  .collection('Buckets')
                  .document('${widget.loggedInUser}')
                  .collection('User')
                  .document(widget.docId)
                  .updateData({"priority": _value.toString()});
            }else{

            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        userEmail: widget.userMail,
                        loggedInUser: widget.loggedInUser)));
          },
          label: Text("Priorität ändern"),
          icon: Icon(Icons.camera,
            size: 30,),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff032e42),
          title: Text(
            "Priorität ändern",
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
                  "Wählen Sie eine neue Priorität für Ihren Bucket",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FluidSlider(
                    sliderColor: Color(0xff8dc6d9),
                    value: _value,
                    onChanged: (double newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                    min: 0.0,
                    max: 100.0,
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
