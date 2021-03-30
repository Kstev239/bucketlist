import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'buy_container.dart';

class BuyDealPage extends StatefulWidget {
  @override
  _BuyDealPageState createState() => _BuyDealPageState();
}

class _BuyDealPageState extends State<BuyDealPage> {

  String searchString;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Technik'),
          backgroundColor: Colors.blue[900],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue[100], Colors.blue[900]]
              )
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      searchString = value.toLowerCase();
                    });
                  },
                ),
              ),
              //Query a snapshot from Firebase for the Logged in User
              StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString.trim() == '')
                      ? Firestore.instance
                      .collection('Technik')
                      .snapshots()
                      : Firestore.instance.
                  collection('Technik')
                      .where('searchIndex',
                      arrayContains: searchString)
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
                    final int buyDealLength = snapshot.data.documents.length;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: buyDealLength,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot _buyDeals =
                          snapshot.data.documents[index];
                          return BuyContainer(
                            name: _buyDeals['name'],
                            link: _buyDeals['link'],
                            price: _buyDeals['price'],
                            picture: _buyDeals['picture'],
                            description: _buyDeals['beschreibung'],
                            discount: _buyDeals['rabatt'],
                            discount2: _buyDeals['rabatt2'],
                          );
                        },
                      ),
                    );
//                    Expanded(
//                      child: Container(
//                        child: Column(
//                          children: <Widget>[
//                            Expanded(
//                              child: Container(
//                                child: ListView.builder(
//                                    itemCount: deals.length,
//                                    itemBuilder: (BuildContext context, int index) {
//                                      return deals[index];
//                                    }),
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}