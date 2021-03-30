import 'package:flutter/material.dart';
import 'buy_info.dart';
class BuyContainer extends StatelessWidget {
  BuyContainer({this.name, this.price, this.link, this.picture, this.description, this.discount, this.discount2});

  final String name;
  final String price;
  final String picture;
  final String link;
  final String description;
  final String discount;
  final String discount2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuyInfoPage(
                name: name,
                price: price,
                picture: picture,
                link: link,
                description: description,
                discount: discount,
                discount2: discount2,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.tealAccent, Colors.black]
              )),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Preis $price €',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$discount',
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$discount2',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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