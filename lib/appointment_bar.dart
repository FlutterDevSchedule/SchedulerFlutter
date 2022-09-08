import 'package:google_sign_in/google_sign_in.dart';

// import 'package:googleapis/calendar/v3.dart';
// import 'package:room_app/calendar_event_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'calendar_controller.dart';

class AppoitmentBar extends StatefulWidget {
  final GoogleSignInAccount user;
  final googleAPI.CalendarApi calendarApi;

  const AppoitmentBar({Key? key, required this.user, required this.calendarApi})
      : super(key: key);

  @override
  State<AppoitmentBar> createState() => _AppoitmentBarState();
// getDataSource()
}


class _AppoitmentBarState extends State<AppoitmentBar> {
  GetCalendarData getData = GetCalendarData();
  List<Meeting> meeting = <Meeting>[];

  void initState() {
    super.initState();
    getAppointment();

  }

  getAppointment(){
    getData.getDataSource(widget.calendarApi).then((test) => {
      test.forEach((value) => {
        setState(() {
          var meetToList= value.toList();
          meeting.add( (value.toList()).length == 4 ? Meeting('eventName', meetToList[1], meetToList[2], meetToList[3]) :  Meeting(meetToList[3], meetToList[1], meetToList[2], meetToList[4]));
          // meeting.add(value.toList());
        })
      })
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
        dataSource: MeetingDataSource(meeting),
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
          getAppointment();
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
