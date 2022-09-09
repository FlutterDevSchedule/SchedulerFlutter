
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GetCalendarData {
   static generateTimeList(){
    List<String> timeList = <String>[];
    for(var i = 7 ; i<19; i++){
      for(var j =0 ; j<4;j++){

        var hour = (i < 10 ? ('0$i') : i).toString();
        var min = (j == 0 ? ('00') : (j) *15).toString();
        var value = '$hour:$min';
        timeList.add(value);
      }

    };
    return timeList;
    // print(timeList);
  }
  Future getEventList(calendarAuth) {
    googleAPI.CalendarApi calendarAPI = calendarAuth;
    var toTime = DateTime.now();
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOff = DateTime.now().timeZoneOffset;
    print(timeZone);
    print(timeZoneOff);
    DateTime startDay = Jiffy(toTime).startOf(Units.MONTH).dateTime;
    DateTime endDay = Jiffy(toTime).endOf(Units.MONTH).dateTime;

    var eventList = calendarAPI.events
        .list('primary', timeMax: endDay.toUtc(), timeMin: startDay.toUtc())
        .then((value) => {value});
    // print(eventList.items);
    return eventList;
    DateTime? eventTime;
    DateTime? startTime;
    DateTime? endTime;
    String? title;
    Color color;

    // List<Meeting> test = <Meeting>[];

    // return eventList;
  }

   Future getDataSource(calendarAuth) async {

    // EventManagment meetings = EventManagment();
    googleAPI.CalendarApi calendarAPI = calendarAuth;
    var toTime = DateTime.now();
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOff = DateTime.now().timeZoneOffset;
    print(timeZone);
    print(timeZoneOff);
    DateTime startDay = Jiffy(toTime).startOf(Units.MONTH).dateTime;
    DateTime endDay = Jiffy(toTime).endOf(Units.MONTH).dateTime;

    var eventList = calendarAPI.events
        .list('primary', timeMax: endDay.toUtc(), timeMin: startDay.toUtc());
    // .then((value) => {value});
    // var eventList = getEventList(calendarAuth);

    DateTime? startTime;
    DateTime? endTime;
    String? title;
    Color color;
    print('działa tu');
    // var timeZoneOff = DateTime.now().timeZoneOffset;

    List<Meeting> meeting = <Meeting>[];
    return eventList.then((value) => {

          for (var elem in value.items!)
            {
              print(elem.start),
              startTime = elem.start!.dateTime?.add(timeZoneOff),
              endTime = elem.end!.dateTime?.add(timeZoneOff),
              title = elem.summary,
              color = Colors.deepOrange,
              meeting.add(Meeting(
                  title.toString(),
                  DateTime.parse(startTime.toString()),
                  DateTime.parse(endTime.toString()),
                  color)),
              //
            },


        });

    // var test = eventList.then((value) => (value)).then((value) => print(value));
    // print(test.then((value) =>{}));
    // return eventList;
    // eventList
    //     .then((item) => {
    //           for (var elem in item.items!)
    //             {
    //               print(elem),
    //               // startTime = elem.start!.dateTime?.add(timeZoneOff),
    //               // endTime = elem.end!.dateTime?.add(timeZoneOff),
    //               // title = elem.summary,
    //               // color = Colors.deepOrange,
    //               // print(startTime),
    //               // meeting.add(Meeting(
    //               //     title.toString(), DateTime.parse(startTime.toString()),
    //               //     DateTime.parse(endTime.toString()), color)),
    //             }
    //         });
    // print(meeting);
    // return meeting ;
  }

  // async WrapedEventData(event){
    // print(event);
    // // var test2;
    // return event.forEach((item){print(item.toList());});
    // print(test);
    // event.forEach((value) => {( value.toList())});

  // }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
