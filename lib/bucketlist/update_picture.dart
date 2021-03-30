import 'dart:convert';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';

class UpdatePicture extends StatefulWidget {
  UpdatePicture({this.loggedInUser, this.docId, this.userMail});
  final String loggedInUser;
  final String docId;
  final String userMail;
  @override
  _UpdatePictureState createState() => _UpdatePictureState();
}

class _UpdatePictureState extends State<UpdatePicture> {
  String newPic;
  String url;
  Future picture(name) async {
    final ref = FirebaseStorage.instance.ref();
    if (ref.child("${name.toLowerCase().trim()}$_selectedIndex.jpg") != null) {
      var image = ref.child("${name.toLowerCase().trim()}$_selectedIndex.jpg");
      url = await image.getDownloadURL();
    }
  }

  Future pickedPicture(name) async {
    final ref = FirebaseStorage.instance.ref();
    var byteImage = await networkImageToByte(picList[_selectedIndex]);
    var uploadImage =
        ref.child('${name.toLowerCase().trim()}$_selectedIndex.jpg');
    StorageUploadTask task = uploadImage.putData(byteImage);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    var image = ref.child("${name.toLowerCase().trim()}$_selectedIndex.jpg");
    url = await image.getDownloadURL();
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (newPic != null) {
              if (newPic != null) {
                await picture(newPic).catchError((e) => pickedPicture(newPic));
              }
              await Firestore.instance
                  .collection('Buckets')
                  .document('${widget.loggedInUser}')
                  .collection('User')
                  .document(widget.docId)
                  .updateData({"url": url});
            }else{

            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        userEmail: widget.userMail,
                        loggedInUser: widget.loggedInUser)));
          },
          label: Text("Bild ändern"),
          icon: Icon(Icons.camera,
          size: 30,),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff032e42),
          title: Text(
            "Bild ändern",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
            color: Color(0xffcacbf),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Suchen Sie nach einem Begriff und suchen Sie sich ein passendes Bild aus",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (index) {
                      newPic = index;
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
                    await networkUrl(newPic);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff032e42)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Suchen",
                      style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: picList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return FlatButton(
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
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? Colors.green
                                  : Colors.white),
                        ),
                        onPressed: () {
                          _onSelected(index);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                // FlatButton(
                //   onPressed: () async {
                //     if (newPic != null) {
                //       if (newPic != null) {
                //         await picture(newPic)
                //             .catchError((e) => pickedPicture(newPic));
                //       }
                //       await Firestore.instance
                //           .collection('Buckets')
                //           .document('${widget.loggedInUser}')
                //           .collection('User')
                //           .document(widget.docId)
                //           .updateData({"url": url});
                //     }
                //     Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => HomePage(
                //                 userEmail: widget.userMail,
                //                 loggedInUser: widget.loggedInUser)));
                //   },
                //   child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           gradient: LinearGradient(
                //               begin: Alignment.bottomLeft,
                //               end: Alignment.topRight,
                //               colors: [Colors.blue[900], Colors.lightBlue])),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text("Bild ändern",
                //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                //       )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
