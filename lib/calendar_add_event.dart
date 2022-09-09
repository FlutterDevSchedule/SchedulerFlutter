import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'appointment_bar.dart';
import 'logged_in_page.dart';
import 'main.dart';

import 'package:googleapis/calendar/v3.dart' as googleAPI;
typedef void callBack(String val);

class AddEventToCallendar extends StatelessWidget {
  final callBack childCallback;
  AddEventToCallendar(this.childCallback);


  calendarInser(title, startTime, endTime, user,)  {
    if (user != null) {
      googleAPI.CalendarApi calendarAPI = user;
      String calendarId = "primary";
      googleAPI.Event event = googleAPI.Event();

      event.summary = title;

      DateTime startDateTime = DateTime.parse("$startTime");
      googleAPI.EventDateTime start = new googleAPI.EventDateTime();
      start.dateTime = startDateTime;
      start.timeZone = "GMT+02:00";

      event.start = start;

      DateTime endDateTime = DateTime.parse("$endTime");
      googleAPI.EventDateTime end = new googleAPI.EventDateTime();
      end.timeZone = "GMT+02:00";
      end.dateTime = endDateTime;

      event.end = end;

      event.attendees = [
        googleAPI.EventAttendee(email: 'd.barchanski@gmail.com')
      ];

      try {
        calendarAPI.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            childCallback('testxD');
            // childCallback('test');
            // AppoitmentBar test = const AppoitmentBar (user: null,);
            // _AppoitmentBarState test = _AppoitmentBarState
            // test.getDataSource();
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
