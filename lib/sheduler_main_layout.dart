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

                                // child: Container(
                                //     color: Color(0xFF20B878),
                                //     child:  Center(
                                //       child: LoggedInPage(user: widget.user,),
                                //     ))
                                child: Container(
                                  color: Color(0xFF20B878),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Expanded(
                                          //child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text('',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: const <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        30, 0, 0, 0),
                                                    child: Expanded(
                                                        child: Text(
                                                            'Sala konferencyjna',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600))
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        30, 0, 0, 0),
                                                    child: Expanded(
                                                      child: Text(
                                                        'Analize room',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 70,
                                                          fontWeight:
                                                          FontWeight.w800,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ]))
                                      ]),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    color: Color(0xFF003F2B),
                                    child: const Center(
                                      child: Text('Sala wolna do końca dnia',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    )))
                          ])),
                  Expanded(flex: 3, child: Container(child: AppoitmentBar())),

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
        ),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () =>
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Create new event'),
                          content: Container(
                              width: 900,
                              child: LoggedInPage(user: widget.user,)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Back'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('Save event'),
                            ),
                          ],
                        ),
                ),

            child: Text('Add event'),
        backgroundColor: Colors.blue));
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