import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'calendar_add_event.dart';
import 'package:jiffy/jiffy.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';

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

class EventManagment {
// Future<Meeting>

  List<Meeting> meeting = <Meeting>[];
  getEvents(user) async {
    // final GoogleAPIClient httpClient = GoogleAPIClient(await user.authHeaders);
    // googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
    googleAPI.CalendarApi calendarAPI = user;
    var toTime = DateTime.now();
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOff = DateTime.now().timeZoneOffset;
    print(timeZone);
    print(timeZoneOff);
    DateTime startDay = Jiffy(toTime)
        .startOf(Units.MONTH)
        .dateTime;
    DateTime endDay = Jiffy(toTime)
        .endOf(Units.MONTH)
        .dateTime;
    var eventList = calendarAPI.events.list(
        'primary', timeMax: endDay.toUtc(), timeMin: startDay.toUtc());
    DateTime? eventTime;
    DateTime? startTime;
    DateTime? endTime;
    String? title;
    Color color;

    List<Meeting> test = <Meeting>[];

    return eventList;
    print('chuj' + eventList.toString());
    eventList.then((item)=>{
      meeting.clear(),
      for(var elem in item.items! ){
        // print(elem)
        startTime = elem.start!.dateTime?.add(timeZoneOff),
        endTime = elem.end!.dateTime?.add(timeZoneOff),
        title = elem.summary,
        color = Colors.deepOrange,
        meeting.add(Meeting(title.toString(), DateTime.parse(startTime.toString()), DateTime.parse(endTime.toString()), color)),
      }
    });
    print(meeting);
    return  meeting;
    eventList.then(
            (events) =>
        {

          events.items?.forEach((event) => {
            // googleAPI.EventDateTime(dateTime: "${event.start}").
            // print(event.toJson()),
            //  eventTime = event.start!.dateTime,
            // print("EVENT ${event.start!.dateTime?.add(timeZoneOff)} ${event.summary} To meet: ${toTime.difference(eventTime!).inMinutes}")
            startTime = event.start!.dateTime?.add(timeZoneOff),
            endTime = event.end!.dateTime?.add(timeZoneOff),
            title = event.summary,
            color = Colors.deepOrange,
            meeting.add(Meeting(title.toString(), DateTime.parse(startTime.toString()), DateTime.parse(endTime.toString()), color)),
            // print(meeting.length)

            test= meeting
          })
        }


    );

    print(test.length);
  }

}
class GoogleAPIClient extends IOClient {
  Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

// @override
// Future<Response> head(Uri url, { Map<String, String> headers}) =>
//     super.head(url, headers: headers..addAll(_headers));
}