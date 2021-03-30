import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'home_page.dart';

class TimeLine {
  String timeLinePointOne;
  String test = 'test';
  Widget leftTimelineTile(String hint, bool start, bool end) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineX: 0.1,
      isLast: end,
      isFirst: start,
      rightChild: Padding(
        padding: const EdgeInsets.only(right: 28.0, left: 8),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            onChanged: (index) {
              timeLinePointOne = index;
              print(timeLinePointOne);
            },
            maxLength: 30,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                filled: true,
                fillColor: Colors.indigo,
                hintText: hint
            ),),
        ),
      ),
      bottomLineStyle: LineStyle(
          color: Colors.cyanAccent,
          width: 6
      ),
      topLineStyle: LineStyle(
          color: Colors.purple,
          width: 6
      ),
      indicatorStyle: IndicatorStyle(
          color: Colors.cyanAccent,
          width: 40,
          iconStyle: IconStyle(
              color: Colors.green,
              iconData: Icons.airplanemode_active
          )
      ),
    );
  }

  Widget rightTimelineTile(String hint, bool start, bool end) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineX: 0.9,
      isLast: end,
      isFirst: start,
      leftChild:
      Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 8),
        child:
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            maxLength: 30,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                filled: true,
                fillColor: Colors.indigoAccent,
                hintText: hint
            ),),
        ),
      ),
      topLineStyle: LineStyle(
          color: Colors.cyanAccent,
          width: 6
      ),
      bottomLineStyle: LineStyle(
          color: Colors.purple,
          width: 6
      ),
      indicatorStyle: IndicatorStyle(
          color: Colors.cyanAccent,
          width: 40,
          iconStyle: IconStyle(
              color: Colors.green,
              iconData: Icons.call_missed_outgoing
          )
      ),
    );
  }
}
  class ZeroTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Column();
  }
  }

  class OneTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Column(
  children: <Widget>[
  TimeLine().leftTimelineTile('Erster Schritt...', true, true)
  ],
  );
  }
  }

  class TwoTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Column(
  children: <Widget>[
    TimeLine().leftTimelineTile('Erster Schritt...', true, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.cyanAccent,
  thickness: 6,
  ),
    TimeLine().rightTimelineTile('Zweiter Schritt...', false, true)
  ],
  );
  }
  }

  class ThreeTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Column(
  children: <Widget>[
    TimeLine().leftTimelineTile('Erster Schritt...', true, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.cyanAccent,
  thickness: 6,
  ),
    TimeLine().rightTimelineTile('Zweiter Schritt...', false, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.purple,
  thickness: 6,
  ),
    TimeLine().leftTimelineTile('Dritter Schritt...', false, true)
  ],
  );
  }
  }

  class FourTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Column(
  children: <Widget>[
    TimeLine().leftTimelineTile('Erster Schritt...', true, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.cyanAccent,
  thickness: 6,
  ),
    TimeLine().rightTimelineTile('Zweiter Schritt...', false, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.purple,
  thickness: 6,
  ),
    TimeLine().leftTimelineTile('Dritter Schritt...', false, false),
  TimelineDivider(
  begin: 0.1,
  end: 0.9,
  color: Colors.cyanAccent,
  thickness: 6,
  ),
    TimeLine().rightTimelineTile('Vierter Schritt...', false, true)
  ],
  );
  }
  }
