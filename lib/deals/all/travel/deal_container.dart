import 'package:flutter/material.dart';
import 'deal_info_page.dart';

class DealContainer extends StatelessWidget {
  DealContainer({this.name, this.link, this.picture,});

  final String name;
  final String link;
  final String picture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoPage(
                name: name,
                link: link,
                picture: picture,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff2f8db3),
              borderRadius: BorderRadius.circular(15),

          // gradient: LinearGradient(
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   colors: [Colors.tealAccent, Colors.blue[700]]
          // )
          ),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(picture),
                    ),
                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Align(
//                      alignment: Alignment.bottomRight,
//                      child: Column(
//                        children: <Widget>[
//                          Container(
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(25)),
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                'Preis $price €',
//                                style: TextStyle(fontWeight: FontWeight.bold),
//                              ),
//                            ),
//                          ),
//                          Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                '$disc',
//                                style: TextStyle(fontWeight: FontWeight.bold,
//                                color: Colors.red, fontSize: 22),
//                              ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
