import 'dart:convert';
import 'update_picture.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:http/http.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'home_page.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'chose_picture.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'settings_overview.dart';

class BucketInfoPage extends StatelessWidget {
  BucketInfoPage(
      {this.name,
      this.activity,
      this.budget,
      this.priority,
      this.docId,
      this.userId,
      this.date,
      this.picture,
      this.message,
      this.userMail});

  final String name;
  final String userMail;
  final String activity;
  final String priority;
  final String budget;
  final String docId;
  final String userId;
  final date;
  final picture;
  final message;

  String percentageModifier(double value) {
    // final roundedValue = value.ceil().toInt().toString();
    var roundedBudget = budget.split(".");
    String budgetValue = roundedBudget[0];
    return '€ $budgetValue';
  }

  deleteFile(String docId, String userId) async {
    return Firestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(Firestore.instance
          .collection('Buckets')
          .document(userId)
          .collection('User')
          .document(docId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff2c4260),
          floatingActionButton: BoomMenu(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            //child: Icon(Icons.add),
            // scrollVisible: scrollVisible,
            overlayColor: Colors.black,
            overlayOpacity: 0.7,
            children: [
              MenuItem(
                  title: "Erledigt",
                  subtitle: "Markiere diesen Bucket als Erledigt",
                  subTitleColor: Colors.white,
                  backgroundColor: Colors.green[900],
                  titleColor: Colors.white,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                  onTap: () {
                    Firestore.instance
                        .collection('Buckets')
                        .document(userId)
                        .collection('User')
                        .document(docId)
                        .updateData({'status': 'true'});
                    Navigator.pop(context);
                  }),
              MenuItem(
                  title: "Bearbeiten",
                  subtitle: "Bearbeite diesen Bucket",
                  subTitleColor: Colors.black,
                  backgroundColor: Colors.white,
                  titleColor: Colors.black,
                  child: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 50,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsOverview(
                                  loggedInUser: userId,
                                  docId: docId,
                                  userMail: userMail,
                                )));
                  }),
              MenuItem(
                  title: "Löschen",
                  subtitle: "Lösche diesen Bucket",
                  subTitleColor: Colors.white,
                  backgroundColor: Colors.red[900],
                  titleColor: Colors.white,
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 50,
                  ),
                  onTap: () {
                    deleteFile(docId, userId);
                    Navigator.pop(context);
                  }),
            ],
            // children: <Widget>[
            // MenuItem(title: null
            // child: Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.delete_forever,
            //       color: Colors.red,
            //       size: 50,
            //     ),
            //     onPressed: () {
            //       deleteFile(docId, userId);
            //       Navigator.pop(context);
            //     },
            //   ),
            // )),
//            IconButton(icon: Icon(Icons.picture_as_pdf, color: Colors.black, size: 50,),
//            onPressed: (){},),
//               IconButton(
//                 icon: Icon(
//                   Icons.settings,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UpdatePicture(
//                                 loggedInUser: userId,
//                                 docId: docId,
//                                 userMail: userMail,
//                               )));
//                 },
//               ),
//               // IconButton(
//               //   icon: Icon(
//               //     Icons.picture_in_picture_alt_rounded,
//               //     color: Colors.purple,
//               //     size: 50,
//               //   ),
//               //   onPressed: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => ChoosePicture(
//               //             )));
//               //   },
//               // ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.check,
//                   color: Colors.green,
//                   size: 50,
//                 ),
//                 onPressed: () {
//                   Firestore.instance
//                       .collection('Buckets')
//                       .document(userId)
//                       .collection('User')
//                       .document(docId)
//                       .updateData({'status': 'true'});
//                   Navigator.pop(context);
//                 },
//               )
//             ],
          ),
//        appBar: AppBar(
//          centerTitle: true,
//          title: Text(
//            name,
//          ),
//          backgroundColor: Colors.grey[900],
//        ),
          body: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              backgroundColor: Color(0xff8dc6d9),
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height / 2.5,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    FittedBox(fit: BoxFit.fill, child: Image.network(picture)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  child: Text(
                    activity,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Datum',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.65,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: CalendarCarousel(
                        maxSelectedDate: DateTime(DateTime.now().year + 50,
                            DateTime.now().month, DateTime.now().day),
                        headerTextStyle: TextStyle(
                            color: Color(0xff9cacbf),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        onDayPressed: (DateTime date, List events) {},
                        weekdayTextStyle: TextStyle(color: Colors.white),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                        ),
                        thisMonthDayBorderColor: Colors.grey,
                        weekFormat: false,
                        selectedDateTime: date.toDate(),
                        daysHaveCircularBorder: true,
                        iconColor: Color(0xff9cacbf),

                        /// null for not rendering any border, true for circular border, false for rectangular border
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 2,
                    height: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Deine Priorität',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FluidSlider(
                    sliderColor: Color(0xff8dc6d9),
                    min: 0.0,
                    max: 100.0,
                    value: double.parse(priority),
                    onChanged: (index) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 2,
                    height: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Dein Budget',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      animationEnabled: false,
                      customColors: CustomSliderColors(
                          trackColor: Color(0xff8dc6d9),
                          progressBarColors: [
                            Color(0xff9cacbf),
                            Color(0xff2b6684),
                            Color(0xffe5f4f9),
                            Color(0xff5ba5c2)
                          ]),
                      startAngle: 180,
                      angleRange: 270,
                      size: 200,
                      infoProperties: InfoProperties(
                          mainLabelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          modifier: percentageModifier),
                    ),
                    min: 0.0,
                    max: 8000.0,
                    initialValue: double.parse(budget),
                    // onChange: (i) {
                    //
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 2,
                    height: 5,
                  ),
                ),
                Text(
                  'Weitere Informationen',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )
              ]),
            )
          ])),
    );
  }
}
