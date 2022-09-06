import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'calendar_add_event.dart';
import 'package:jiffy/jiffy.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';



class EventManagment {

  getEvents(user) async {
    final GoogleAPIClient httpClient = GoogleAPIClient(await user.authHeaders);
    googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
    var toTime = DateTime.now();
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOff = DateTime.now().timeZoneOffset;
    print(timeZone);
    print(timeZoneOff);
    DateTime startDay = Jiffy(toTime)
        .startOf(Units.DAY)
        .dateTime;
    DateTime endDay = Jiffy(toTime)
        .endOf(Units.DAY)
        .dateTime;
    var eventList = calendarAPI.events.list(
        'primary', timeMax: endDay.toUtc(), timeMin: startDay.toUtc());
    DateTime? eventTime;
    eventList.then(
            (events) =>
        {
          events.items?.forEach((event) => {
            // googleAPI.EventDateTime(dateTime: "${event.start}").
            print(event.toJson()),
             eventTime = event.start!.dateTime,
            print("EVENT ${event.start!.dateTime?.add(timeZoneOff)} ${event.summary} To meet: ${toTime.difference(eventTime!).inMinutes}")
          })});
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
