import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChoosePicture extends StatefulWidget {
  @override
  _ChoosePictureState createState() => _ChoosePictureState();
}

class _ChoosePictureState extends State<ChoosePicture> {
  String pictureName;
  List picList = [];

  Widget show = Text("Hier");

  Future networkUrl(name) async {
    picList.clear();
    Response response = await get(
        'https://pixabay.com/api/?key=16084571-ece772a43c16adc1643e9a33e&q=$name&image_type=photo');
    String data = response.body;
    if (response.statusCode == 200) {
      int totalPicCount = jsonDecode(data)['total'];
      if (totalPicCount > 0) {
        for (int i = 0; i < 5; i++) {
          String link = jsonDecode(data)['hits'][i]['webformatURL'];
          picList.add(link);
        }
      }
      print("done");
    }
  }
  Color pickedColor = Colors.black;
  var colorBool = false;
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    show = Image.network(picList[index]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (index) {
                  pictureName = index;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  hintText: 'Suche nach neuem Bild...',
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                ),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await networkUrl(pictureName);
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.blue[900], Colors.lightBlue])),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Bild ändern",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: picList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Column(
                        children: <Widget>[
                          FlatButton(
                            child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      picList[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                  ),
                                ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: _selectedIndex != null && _selectedIndex == index
                                    ? Colors.green
                                    : Colors.white
                              ),
                            ),
                            onPressed: (){
                              _onSelected(index);
                            },
                          ),
                        ],
                      );
                  },
              ),
            ),
            show
          ],
        ),
    );
  }
}
