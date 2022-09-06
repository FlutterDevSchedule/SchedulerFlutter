import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart';
import 'package:room_app/calendar_event_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;

class AppoitmentBar extends StatefulWidget {
  final GoogleSignInAccount user;
  final googleAPI.CalendarApi calendarApi;

  const AppoitmentBar({Key? key,  required this.user, required this.calendarApi}) : super(key: key);


  @override
  State<AppoitmentBar> createState() => _AppoitmentBarState();

}

class _AppoitmentBarState extends State<AppoitmentBar> {
  EventManagment meetings = EventManagment();
  List<Meeting> meetList = <Meeting>[];
  // MeetingData test =  MeetingData();
  // GoogleSignInAccount usr= this.user;
  @override
  void initState() {
    super.initState();
    getDataSource();
  }
  getDataSource() {
    EventManagment meetings = EventManagment();
    var test = meetings.getEvents(widget.calendarApi);
    print('chuj');
    DateTime? startTime;
    DateTime? endTime;
    String? title;
    Color color;

    var timeZoneOff = DateTime.now().timeZoneOffset;
    print(test.then((item)=>{
      meetList.clear(),
      for(var elem in item.items! ){
        // print(elem)
        startTime = elem.start!.dateTime?.add(timeZoneOff),
        endTime = elem.end!.dateTime?.add(timeZoneOff),
        title = elem.summary,
        color = Colors.deepOrange,
        meetList.add(Meeting(title.toString(), DateTime.parse(startTime.toString()), DateTime.parse(endTime.toString()), color)),
      },
      setState(() {
        print(meetList);
        meetList = meetList;
      })
    }));
    return test;
  }
  @override
  Widget build(BuildContext context) {
    // final test =
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
        dataSource: MeetingDataSource(meetList),
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      appBar: AppBar(
          title: TextButton(
        child: Text('baton', style: TextStyle(color: Colors.red)),
        onPressed: () {
          getDataSource();
        },
      )),
    );
  }


}


// class MeetingData {
//   static final _eventManagment = EventManagment();
//
//   static Future<Meeting> _MeetingList(user) => _eventManagment.getEvents(user);
// }

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
