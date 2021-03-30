import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'deal_container.dart';

class DealPage extends StatefulWidget {
  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  String searchString;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Besten Reiseziele'),
          centerTitle: true,
          backgroundColor: Color(0xff032e42)
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff9cacbf)
              // gradient: LinearGradient(
              //     begin: Alignment.bottomLeft,
              //     end: Alignment.topRight,
              //     colors: [Colors.blue[100], Colors.blue[900]])
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Suche nach Reisezielen...',
                      hintStyle: TextStyle(color: Colors.black,)
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchString = value.toLowerCase();
                    });
                  },
                ),
              ),
              //Query a snapshot from Firebase for the Logged in User
              StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString.trim() == '')
                      ? Firestore.instance.collection('Deals').orderBy('name').snapshots()
                      : Firestore.instance
                          .collection('Deals')
                          .where('searchIndex', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blueAccent,
                          size: 70,
                        ),
                      );
                    }
                    final int travelDealLength = snapshot.data.documents.length;
                    return
                        Expanded(
                            child: ListView.builder(
                                itemCount: travelDealLength,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot _travelDeals =
                                      snapshot.data.documents[index];
                                  return DealContainer(
                                    name: _travelDeals['name'],
                                    link: _travelDeals['link'],
                                    picture: _travelDeals['picture'],
                                  );
                                }),

                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
