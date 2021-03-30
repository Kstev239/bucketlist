import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'activity_container.dart';

class ActivityDealPage extends StatefulWidget {
  @override
  _ActivityDealPageState createState() => _ActivityDealPageState();
}

class _ActivityDealPageState extends State<ActivityDealPage> {
  String searchString;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aktivitäten'),
          backgroundColor: Colors.blue[900],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue[100], Colors.blue[900]])),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Suche nach Aktivitäten...',
                    hintStyle: TextStyle(color: Colors.white,)
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
                    ? Firestore.instance.collection('Activity').snapshots()
                    : Firestore.instance
                        .collection('Activity')
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
                  final int activityDealLength = snapshot.data.documents.length;
                  return Expanded(
                          child: ListView.builder(
                            itemCount: activityDealLength,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot _activityDeals =
                                  snapshot.data.documents[index];
                              return ActivityContainer(
                                name: _activityDeals['name'],
                                link: _activityDeals['link'],
                                price: _activityDeals['price'],
                                picture: _activityDeals['picture'],
                                description: _activityDeals['beschreibung'],
                              );
                            },
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
