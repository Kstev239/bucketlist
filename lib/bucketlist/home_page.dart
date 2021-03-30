import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';
import 'start_page.dart';
import 'package:the_bucket_list/bucketlist/grid_view_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bucket_list/deals/all/experience/activity_deal_page.dart';
import 'package:the_bucket_list/deals/all/travel/great_deal_page.dart';
import 'package:the_bucket_list/main.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:the_bucket_list/deals/all/buy/buy_deal_page.dart';
import 'package:the_bucket_list/motivation/motivation.dart';
import 'package:the_bucket_list/inspiration/inspiration.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'time_line.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.userEmail, @required this.loggedInUser});
  final loggedInUser;
  final userEmail;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activity = 'Reisen';
  double _value = 0.0;
  String newName;
  String picName;
  double _budgetValue = 0.0;
  int _currentPage = 0;
  List<DocumentSnapshot> _myDocCount;
  int count;
  int bucketsDone = 0;
  double _height = 320;
  Map<String, double> dataMap = Map();
  var _currentDate = DateTime.now();
  String nameEmpty = '';
  Widget loader = Text('');
  var _image;
  Icon pictureIcon = Icon(
    Icons.perm_media,
    size: 30,
  );
  String message = '';
  bool pictureSearchField = true;
  int timeLineNumber = 0;
  List timeLine = [
    ZeroTimeLine(),
    OneTimeLine(),
    TwoTimeLine(),
    ThreeTimeLine(),
    FourTimeLine()
  ];
  String url;
  List picList = [];
  Widget show = Text("Hier");
  int _selectedIndex = 0;



  @override
  void initState() {
    counter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Neuer Bucket'),
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              pictureIcon = Icon(
                Icons.perm_media,
                size: 30,
              );
              pictureSearchField = true;
            });
            bottomSheet(context);
          },
        ),
        drawer: Drawer(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.elliptical(70, 50)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xff2f8db3), Color(0xff8dc6d9)])),
              child: ListView(
                children: <Widget>[
                  Text(
                    '${widget.userEmail}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 25,
                      right: 25,
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Besten Reise Deals',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff012e67),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DealPage()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 25,
                      right: 25,
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Besten Aktivitäten Deals',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff012e67),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivityDealPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width / 2.7,
                      showChartValuesInPercentage: false,
                      showChartValues: true,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: Colors.grey[200],
                      colorList: [Colors.red, Colors.green],
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                      decimalPlaces: 0,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                        color: Colors.blueGrey[900].withOpacity(0.9),
                      ),
                      chartType: ChartType.ring,
                    ),
                  ),
                  Text(
                    'Total: $count Buckets',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color(0xff012e67),
                      child: Text(
                        'Vorschläge',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InspirationPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Color(0xff012e67),
                        child: new Text(
                          'Abmelden',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Settings(email: widget.userEmail)));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff032e42),
          title: const Text(
            'Deine Bucketlist',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: getPage(_currentPage),
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 400),
          height: 50,
          index: 0,
          color: Color(0xff032e42),
          backgroundColor: Color(0xff9cacbf),
          buttonBackgroundColor: Colors.white,
          items: <Widget>[
            const Icon(
              Icons.list,
              color: Color(0xff9cacbf),
            ),
            const Icon(Icons.grid_on, color: Color(0xff9cacbf))
          ],
          onTap: (index) {
            setState(() {
              counter();
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }

  /// Helper Function for a libary
  String percentageModifier(double value) {
    final roundedValue = value.ceil().toInt().toString();
    return '€ $roundedValue';
  }

  /// API call to retrieve 5 different pictures that
  /// are linked to the keyword
  Future networkUrl1(name) async {
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
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Counts the buckets that are marked as "done"
  /// to display them in the Piechart
  Future counter() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('Buckets')
        .document(widget.loggedInUser)
        .collection('User')
        .orderBy('time', descending: true)
        .getDocuments();
    _myDocCount = _myDoc.documents;
    int bucketCount = 0;
    for (int i = 0; i < _myDocCount.length; i++) {
      if (_myDocCount[i].data['status'] == 'true') {
        bucketCount = bucketCount + 1;
      }
    }
    setState(() {
      count = _myDocCount.length;
      bucketsDone = bucketCount;
      double open = count - bucketsDone.toDouble();
      dataMap.clear();
      dataMap.putIfAbsent("Offen", () => open);
      dataMap.putIfAbsent("Erledigt", () => bucketsDone.toDouble());
    });
  }


  Future picture(name) async {
    final ref = FirebaseStorage.instance.ref();
    if (ref.child("${name.toLowerCase().trim()}$_selectedIndex.jpg") != null) {
      var image = ref.child("${name.toLowerCase().trim()}$_selectedIndex.jpg");
      url = await image.getDownloadURL();
    }
  }


  /// Get access to the galerry of the device,
  /// so the user can pick one of his own pictures
  Future getImage() async {
    final ref = FirebaseStorage.instance.ref();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    String _time = DateTime.now().millisecondsSinceEpoch.toString();
    var uploadImage = ref.child('${widget.loggedInUser}+$_time.jpg');
    StorageUploadTask task = uploadImage.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    var newImage = ref.child("${widget.loggedInUser}+$_time.jpg");
    url = await newImage.getDownloadURL();
    print(url);
  }

  /// Old Function to get 1 Picture that fits the
  /// Search Word
  // Future networkUrl(name) async {
  //   final ref = FirebaseStorage.instance.ref();
  //   Response response = await get(
  //       'https://pixabay.com/api/?key=16084571-ece772a43c16adc1643e9a33e&q=$name&image_type=photo');
  //   String data = response.body;
  //   if (response.statusCode == 200) {
  //     int totalPicCount = jsonDecode(data)['total'];
  //     if (totalPicCount > 0) {
  //       String link = jsonDecode(data)['hits'][0]['webformatURL'];
  //       var byteImage = await networkImageToByte(link);
  //       var uploadImage = ref.child('${name.toLowerCase().trim()}.jpg');
  //       StorageUploadTask task = uploadImage.putData(byteImage);
  //       StorageTaskSnapshot taskSnapshot = await task.onComplete;
  //       var image = ref.child("${name.toLowerCase().trim()}.jpg");
  //       url = await image.getDownloadURL();
  //     } else {
  //       var sorryImage = ref.child("sorry.png");
  //       url = await sorryImage.getDownloadURL();
  //     }
  //   }
  // }

  /// Upload the Picture that was picked by the user to Firebase Storage
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

  /// List of Widgets that gets displayed
  /// regarding the Bottom Navigation Bar
  Widget getPage(pageNumber) {
    List displayPage = [
      StartPage(
        loggedInUser: widget.loggedInUser,
        userEmail: widget.userEmail,
      ),
      GridViewPage(
        loggedInUser: widget.loggedInUser,
        count: count,
        myDocCount: _myDocCount,
        userEmail: widget.userEmail,
      )
    ];
    return displayPage[pageNumber];
  }

  /// Creates a Bottom Sheet where the User can create
  /// a new Bucket
  void bottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.only(),
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  color: Color(0xff032e42),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Neuen Bucket erstellen',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Kategorie: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white70),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        hint: Text(
                                          activity,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        items: <String>[
                                          'Reisen',
                                          'Aktivität',
                                          'Erleben',
                                          'Festivals',
                                          'Lernen',
                                          'Kaufen',
                                          'Sonstige'
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (index) {
                                          setState(() {
                                            activity = index;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: _height,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Bucketname',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: TextField(
                                  maxLength: 90,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: 'Bucketname...',
                                      hintStyle: TextStyle(color: Colors.black),
                                      fillColor: Colors.blueAccent,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onChanged: (name) {
                                    newName = name;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Bildersuche',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.info,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _information();
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15, right: 15, left: 15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 9,
                                      child: TextField(
                                        enabled: pictureSearchField,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Wort für die Bildersuche...',
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            fillColor: Colors.blueAccent,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),),),
                                        onChanged: (pic) {
                                          picName = pic;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: pictureIcon,
                                        onPressed: () async {
                                          /// If a user uses his own picture, update
                                          /// the Icon as soon the file is uploaded
                                          /// to the storage
                                          await getImage();
                                          setState(() {
                                            pictureIcon = Icon(Icons.check,
                                                size: 30, color: Colors.green);
                                            pictureSearchField = false;
                                          },);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  if (pictureSearchField == true) {
                                    _height = 530;
                                    await networkUrl1(picName);
                                    setState(() {});
                                  } else {}
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xff8dc6d9)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Suchen",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Datum',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CalendarCarousel(
                                      headerTitleTouchable: true,
                                      headerTextStyle: TextStyle(
                                          color: Color(0xff032e42),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                      maxSelectedDate: DateTime(
                                          DateTime.now().year + 50,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      onDayPressed:
                                          (DateTime date, List events) {
                                        setState(() {
                                          _currentDate = date;
                                        });
                                      },
                                      weekdayTextStyle:
                                          TextStyle(color: Colors.black),
                                      weekendTextStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                      iconColor: Color(0xff032e42),
                                      thisMonthDayBorderColor: Colors.grey,
                                      weekFormat: false,
//                                height: 400.0,
                                      selectedDateTime: _currentDate,
                                      daysHaveCircularBorder: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Priorität',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FluidSlider(
                                  sliderColor: Color(0xff8dc6d9),
                                  value: _value,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _value = newValue;
                                    });
                                  },
                                  min: 0.0,
                                  max: 100.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          height: 5,
                          thickness: 4,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Dein Budget',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        modifier: percentageModifier),
                                  ),
                                  min: 0.0,
                                  max: 8000.0,
                                  initialValue: 0,
                                  onChange: (double value) {
                                    setState(() {
                                      _budgetValue = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Infos',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              Text('(optional)'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      fillColor: Color(0xFFFFFFFF),
                                      filled: true,
                                      hintText:
                                          'Beschreibe deinen Bucket oder füge zusätzliche Informationen hinzu...',
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  maxLines: 5,
                                  maxLength: 180,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (index) {
                                    message = index;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      loader,
                      Text(
                        nameEmpty,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () async {
                                  if (newName != null) {
                                    if (url != null || picName != null) {
                                      setState(() {
                                        loader = SpinKitCircle(
                                          size: 80,
                                          color: Color(0xff9cacbf),
                                        );
                                      });
                                      if (picName != null) {
                                        await picture(picName).catchError(
                                            (e) => pickedPicture(picName));
                                      }
                                      //                              await networkUrl(picName);
                                      await Firestore.instance
                                          .collection('Buckets')
                                          .document('${widget.loggedInUser}')
                                          .collection('User')
                                          .document()
                                          .setData({
                                        'name': newName,
                                        'activity': activity,
                                        'priority': _value.toString(),
                                        'budget': _budgetValue.toString(),
                                        'status': false,
                                        'date': _currentDate,
                                        'url': url,
                                        'time': DateTime.now()
                                            .millisecondsSinceEpoch,
                                        'infos': message,
                                      });
                                      counter();
                                      setState(() {
                                        newName = null;
                                        picName = null;
                                        message = "";
                                        picList.clear();
                                        _selectedIndex = 0;
                                        setState(() {
                                          pictureIcon = Icon(
                                            Icons.perm_media,
                                            size: 30,
                                          );
                                          pictureSearchField = true;
                                        });
                                        loader = Text('');
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      setState(() {
                                        nameEmpty = 'Kein Bild gewählt...';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      nameEmpty = 'Kein Name gewählt...';
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff5ba5c2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12.0,
                                              bottom: 12,
                                              left: 8,
                                              right: 15),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                'Hinzufügen',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )

                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  /// Creates a Alert Dialog, if the user needs more information
  Future<void> _information() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.blue[300],
          title: Text(
            'Bildersuche',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Gib 1. passendes Wort für die Bildersuche ein!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  '1.Beispiel:',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '- Bucketname: "Die Pyramiden sehen"',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '- Bildersuche: "Pyramiden"',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '2.Beispiel:',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '- Bucketname: "Nach Hawaii reisen"',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '- Bildersuche: "Hawaii"',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Schließen',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
