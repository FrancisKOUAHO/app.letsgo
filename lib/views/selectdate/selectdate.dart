import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../theme/LetsGo_theme.dart';

class Selectdate extends StatefulWidget {
  @override
  _SelectdateState createState() => _SelectdateState();
}

List<DateTime> presentDates = [
  DateTime(2020, 11, 1),
  DateTime(2020, 11, 3),
  DateTime(2020, 11, 4),
  DateTime(2020, 11, 5),
  DateTime(2020, 11, 6),
  DateTime(2020, 11, 9),
  DateTime(2020, 11, 10),
  DateTime(2020, 11, 11),
  DateTime(2020, 11, 15),
  DateTime(2020, 11, 22),
  DateTime(2020, 11, 23),
];
List<DateTime> absentDates = [
  DateTime(2020, 11, 2),
  DateTime(2020, 11, 7),
  DateTime(2020, 11, 8),
  DateTime(2020, 11, 12),
  DateTime(2020, 11, 13),
  DateTime(2020, 11, 14),
  DateTime(2020, 11, 16),
  DateTime(2020, 11, 17),
  DateTime(2020, 11, 18),
  DateTime(2020, 11, 19),
  DateTime(2020, 11, 20),
];

class _SelectdateState extends State<Selectdate> {
  DateTime _currentDate2 = DateTime.now();

  static Widget _presentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );

  static Widget _absentIcon(String day) => CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;

  var len = min(absentDates.length, presentDates.length);
  late double cHeight;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: 420,
      weekdayTextStyle: TextStyle(color: LetsGoTheme.black),
      childAspectRatio: 1.05,
      todayBorderColor: LetsGoTheme.main,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
        for (var event in events) {
          print(event.title);
        }
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: LetsGoTheme.main,
      ),
      thisMonthDayBorderColor: LetsGoTheme.main,
      selectedDayButtonColor: LetsGoTheme.main,
      selectedDayTextStyle: const TextStyle(color: Colors.white),
      selectedDayBorderColor: LetsGoTheme.main,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: const CircleBorder(
        side: BorderSide(
          color: Color(0xff4376FF),
        ),
      ),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      headerTextStyle: TextStyle(
          color: LetsGoTheme.main, fontSize: 20, fontWeight: FontWeight.w700),
      showHeader: true,
      iconColor: LetsGoTheme.main,
      todayTextStyle: TextStyle(
        color: LetsGoTheme.main,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.white,
      daysTextStyle: TextStyle(color: LetsGoTheme.main),
      // prevDaysTextStyle: TextStyle(
      //   fontSize: 16,
      //   color: Color.fromARGB(255, 218, 218, 218),
      // ),
      // nextDaysTextStyle: TextStyle(
      //   fontSize: 16,
      //   color: Color.fromARGB(255, 218, 218, 218),
      // ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pour quand ?',
          style: TextStyle(
              color: LetsGoTheme.black,
              fontWeight: FontWeight.w400,
              fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: LetsGoTheme.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _calendarCarouselNoHeader,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                            side: BorderSide(width: 1, color: LetsGoTheme.main),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text('Disponible'),
                      ),
                       SizedBox(
                        width: MediaQuery.of(context).size.height * 0.09,
                      ),
                      Container(
                        width: 30,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 220, 220, 220),
                            shape: BoxShape.circle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text('Indisponible'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LetsGoTheme.main,
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: const Text(
                            'Valider',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        radius: MediaQuery.of(context).size.height * 0.022,
      ),
      title: Text(
        data,
      ),
    );
  }
}
