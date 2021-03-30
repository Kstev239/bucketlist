import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'home_page.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class BucketInfoPage extends StatelessWidget {
  BucketInfoPage({
    this.name,
    this.activity,
    this.budget,
    this.priority,
    this.docId,
    this.userId,
    this.date,
    this.picture,
    this.message
  });

  final String name;
  final String activity;
  final String priority;
  final String budget;
  final String docId;
  final String userId;
  final date;
  final picture;
  final message;
  String percentageModifier(double value) {
    final roundedValue = value.ceil().toInt().toString();
    return '€ $roundedValue';
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
        floatingActionButton: FabCircularMenu(
          ringColor: Colors.white,
          ringWidth: 150,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 50,
              ),
              onPressed: () {
                deleteFile(docId, userId);
                Navigator.pop(context);
              },
            ),
//            IconButton(icon: Icon(Icons.picture_as_pdf, color: Colors.black, size: 50,),
//            onPressed: (){},),
//            IconButton(icon: Icon(Icons.settings, color: Colors.grey, size: 50,),
//              onPressed: (){},),
            IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.green,
                size: 50,
              ),
              onPressed: () {
                Firestore.instance
                    .collection('Buckets')
                    .document(userId)
                    .collection('User')
                    .document(docId)
                    .updateData({'status': 'true'});
                Navigator.pop(context);
              },
            )
          ],
        ),
//        appBar: AppBar(
//          centerTitle: true,
//          title: Text(
//            name,
//          ),
//          backgroundColor: Colors.grey[900],
//        ),
        body: CustomScrollView(
          slivers: <Widget> [
            SliverAppBar(
              centerTitle: true,
              title: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black,
              pinned: true,
              expandedHeight: 400,
              flexibleSpace: FlexibleSpaceBar(
                background: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(picture)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
//                Container(
//                  color: Colors.grey[700],
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Expanded(
//                        child: ListView(
//                          children: <Widget>[
////                            Padding(
////                              padding: const EdgeInsets.all(12.0),
////                              child: Align(
////                                alignment: Alignment.topCenter,
////                                child: ClipRRect(
////                                  borderRadius: BorderRadius.circular(15),
////                                  child: Image.network(picture),
////                                ),
////                              ),
////                            ),
//                            Text(
//                              name,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 24,
//                                  color: Colors.white),
//                              textAlign: TextAlign.center,
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(bottom: 8.0),
//                              child: Text(
//                                activity,
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold, color: Colors.white),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.symmetric(horizontal: 15),
//                              child: Divider(
//                                color: Colors.white,
//                                thickness: 2,
//                                height: 5,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 15.0),
//                              child: Text(
//                                'Dein gewähltes Datum',
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 22,
//                                    color: Colors.white),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(left: 15, right: 15),
//                              child: Container(
//                                height: MediaQuery.of(context).size.height / 1.65,
//                                child: Padding(
//                                  padding: const EdgeInsets.only(right: 15.0, left: 15),
//                                  child: CalendarCarousel(
//                                    onDayPressed: (DateTime date, List events) {},
//                                    weekdayTextStyle: TextStyle(color: Colors.white),
//                                    weekendTextStyle: TextStyle(
//                                      color: Colors.red,
//                                    ),
//                                    thisMonthDayBorderColor: Colors.grey,
//                                    weekFormat: false,
//                                    selectedDateTime: date.toDate(),
//                                    daysHaveCircularBorder: false,
//
//                                    /// null for not rendering any border, true for circular border, false for rectangular border
//                                  ),
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.symmetric(horizontal: 15),
//                              child: Divider(
//                                thickness: 2,
//                                height: 5,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Text(
//                                'Deine Priorität',
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 22),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: FluidSlider(
//                                sliderColor: Colors.tealAccent[200],
//                                min: 0.0,
//                                max: 100.0,
//                                value: double.parse(priority),
//                                onChanged: (index) {},
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.symmetric(horizontal: 15),
//                              child: Divider(
//                                thickness: 2,
//                                height: 5,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Text(
//                                'Dein Budget',
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 22),
//                                textAlign: TextAlign.center,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: SleekCircularSlider(
//                                appearance: CircularSliderAppearance(
//                                  infoProperties:
//                                  InfoProperties(modifier: percentageModifier),
//                                ),
//                                min: 0.0,
//                                max: 3000.0,
//                                initialValue: double.parse(budget),
//                                onChange: (i) {},
//                              ),
//                            ),
//                          ],
//                        ),
//                      )
//                    ],
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  child: Text(
                    activity,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
                        onDayPressed: (DateTime date, List events) {},
                        weekdayTextStyle: TextStyle(color: Colors.white),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                        ),
                        thisMonthDayBorderColor: Colors.grey,
                        weekFormat: false,
                        selectedDateTime: date.toDate(),
                        daysHaveCircularBorder: false,

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
                    sliderColor: Colors.tealAccent[200],
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
                      infoProperties:
                      InfoProperties(modifier: percentageModifier),
                    ),
                    min: 0.0,
                    max: 3000.0,
                    initialValue: double.parse(budget),
                    onChange: (i) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 2,
                    height: 5,
                  ),
                ),
                Text('Weitere Informationen', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
                  textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                      child: Container(
                        height: MediaQuery.of(context).size.height/4,
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18),
                          textAlign: TextAlign.center,),
                      )),
                )
              ]),
            )
          ]
        )
      ),
    );
  }
}
