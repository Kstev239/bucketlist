import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityInfoPage extends StatelessWidget {
  ActivityInfoPage(
      {this.name, this.link, this.price, this.picture, this.description});

  final String name;
  final String link;
  final String price;
  final String picture;
  final String description;
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
        backgroundColor: Color(0xff9cacbf),
        appBar: AppBar(
          title: Text('$name'),
          centerTitle: true,
          backgroundColor: Color(0xff032e42),
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
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Align(
//                alignment: Alignment.bottomRight,
//                child: Container(
//                  decoration: BoxDecoration(
//                      color: Colors.blueGrey[300],
//                      borderRadius: BorderRadius.circular(25)),
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text(
//                      'Preis $price €',
//                      style:
//                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                    ),
//                  ),
//                ),
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xff032e42),
                child: Text('Zu den Angeboten', style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white),),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
