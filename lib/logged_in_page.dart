import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:room_app/api/google_signin_api.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'calendar_add_event.dart';
import 'calendar_event_list.dart';
import 'main.dart';
import 'inserted_component.dart';

class LoggedInPage extends StatefulWidget {
  final GoogleSignInAccount user;

  const LoggedInPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _LoggedInPage createState() => _LoggedInPage();
}

class _LoggedInPage extends State<LoggedInPage> {
  AddEventToCallendar addToCallendar = AddEventToCallendar();
  ImportElement elementTest = ImportElement();
  EventManagment eventManagment = EventManagment();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();

  // getCredential(user) async{
  //
  // final GoogleAPIClient httpClient =
  // GoogleAPIClient(await user.authHeaders);
  // return httpClient;
  // // googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
  // // googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
  // // return googleAPI.CalendarApi(httpClient);
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Logged in'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      title: '',
                    ),
                  ));
                },
                child: Text('logout'),
                style: TextButton.styleFrom(primary: Colors.amber)),
            // , style: TextStyle(color: Colors.white),))
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 3, 5),
                                maxTime: DateTime(2200, 6, 7),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              setState(() {
                                this.startTime = date;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Text(
                            'Event Start Time',
                            style: TextStyle(color: Colors.white),
                          ))),
                  Expanded(child: Text('$startTime')),
                  Expanded(child: Text('Test',style: TextStyle(color: Colors.red),)),
                  Expanded(child: ImportElement())

                ],
              ),
              Row(
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2019, 3, 5),
                            maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            this.endTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                        'Event End Time',
                        style: TextStyle(color: Colors.white),
                      )),
                  Text('$endTime'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _eventName,
                  decoration: InputDecoration(hintText: 'enter Event Name'),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      child: Text(
                        'insert',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addToCallendar.calendarInser(
                            _eventName.text, startTime, endTime, widget.user);
                      }),
                  TextButton(
                      onPressed: () {
                        eventManagment.getEvents(widget.user);
                      },
                      child: Text('get Events',
                          style: TextStyle(color: Colors.white)))
                ],
              ),
            ],
          ),
        ),
      );
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
