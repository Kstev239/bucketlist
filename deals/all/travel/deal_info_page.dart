import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {

  InfoPage({this.name, this.link, this.picture,});

  final String name;
  final String link;
  final String picture;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$name'),
        ),
        body: ListView(
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(picture),
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Text('Dauer: $dauer Tage', style:
//                  TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Align(
//                    alignment: Alignment.bottomRight,
//                    child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.black,
//                          borderRadius: BorderRadius.circular(25)),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          '$price €',
//                          style:
//                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                child: Text('Zu den Angeboten', style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: () {
                  _launchURL();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                height: 5,
                thickness: 3,
                color: Colors.black,
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text('Unser Rabattcode:',style: TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 25),
//                    textAlign: TextAlign.center,),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 8.0),
//                      child: Container(
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(15),
//                            gradient: LinearGradient(
//                                begin: Alignment.bottomLeft,
//                                end: Alignment.topRight,
//                                colors: [Colors.yellow, Colors.red]
//                            )
//                        ),
//                        child:
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text(discount, style: TextStyle(
//                              color: Colors.black,
//                              fontWeight: FontWeight.bold,
//                              fontSize: 25),
//                            textAlign: TextAlign.center,),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
          ],
        ),
      ),
    );
  }
}
