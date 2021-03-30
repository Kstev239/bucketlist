import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:url_launcher/url_launcher.dart';

class InspirationContainer extends StatelessWidget {

  InspirationContainer({this.title, this.activity, this.picture, this.link, this.text});

  final String title;
  final String activity;
  final String picture;
  final String link;
  final String text;

  _launchURL() async {
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        front: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white, Colors.blue]
              )
          ),
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Image.network(picture)),
              Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
              Text(activity),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white, Colors.blue]
              )
          ),
          height: MediaQuery.of(context).size.height/2.5,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
              ),
              Text(text, style: TextStyle(fontSize: 18, color: Colors.black), textAlign: TextAlign.center, ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.blue,
                  child: Text('Siehs dir an', style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: () {
                    _launchURL();
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}