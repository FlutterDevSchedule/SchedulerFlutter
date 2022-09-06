import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_app/calendar_event_list.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'appointment_bar.dart';
import 'logged_in_page.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;

class MainLayout extends StatefulWidget {
  final GoogleSignInAccount user;
  final googleAPI.CalendarApi calendarApi;

  const MainLayout({
    Key? key,
    required this.user, required this.calendarApi,
  }) : super(key: key);

  @override
  _MainLayout createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  EventManagment eventManagment = EventManagment();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 7,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Container(
                                    color: Color(0xFF20B878),
                                    child:  Center(
                                      child: LoggedInPage(user: widget.calendarApi,),
                                    ))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  color: Color(0xFF003F2B),
                                ))
                          ])),
                  Expanded(
                      flex: 3,

                      child: Container(
                          color: Colors.white,
                          child:AppoitmentBar(user: widget.user,calendarApi: widget.calendarApi,)
                        // child: TextButton(
                        //     onPressed: () {
                        //       eventManagment.getEvents(widget.user);
                        //     },
                        //     child: const Text('get Events',
                        //         style: TextStyle(color: Colors.black))),
                      )
                  ),
                ])),
          ],
        ));
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