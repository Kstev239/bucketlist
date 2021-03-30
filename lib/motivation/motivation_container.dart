import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class MotivationContainer extends StatelessWidget {

  MotivationContainer({this.text, this.author});

  final String text;
  final String author;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.white, Colors.grey]
          )
        ),
        child: Column(
          children: <Widget>[
            Text(text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text(author),
          ],
        ),
      ),
    );
  }
}
