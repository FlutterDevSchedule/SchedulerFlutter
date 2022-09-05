import 'dart:developer';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'logged_in_page.dart';
import 'main.dart';

import 'package:googleapis/calendar/v3.dart' as googleAPI;

class AddEventToCallendar {
  calendarInser(title, startTime, endTime, user) async {
    if (user != null) {
      final GoogleAPIClient httpClient = GoogleAPIClient(await user.authHeaders);
      googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
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

      event.attendees = [googleAPI.EventAttendee(email: 'd.barchanski@gmail.com')];


      try {
        calendarAPI.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
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
