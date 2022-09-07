import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'calendar_add_event.dart';
import 'calendar_event_list.dart';
import 'inserted_component.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

const List<String> hourList = <String>['8:00', '8:15', '8:30', '9:00',
  '9:15', '9:30', '10:00', '10:15', '10:30', '11:00', '11:15', '11:30',
  '12:00', '12:15', '12:30', '13:0', '13:15', '13:30', '14:00', '14:15',
  '14:30', '15:00', '15:15', '15:30', '16:00', '16:15', '16:30', '17:00',
  '17:15', '17:30'];

class LoggedInPage extends StatefulWidget {
  final googleAPI.CalendarApi user;

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
  String choiceDay = 'Set Day';
  String firstElementList = hourList.first;

  getStartEventFullDate() {
    print('$choiceDay $firstElementList');
    print(DateTime.parse('$choiceDay $firstElementList'));
  }

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
          body: Container(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(child: Text('Choice day :')),
            Expanded(child: TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2200, 6, 7),
                      theme: const DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                          TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                      setState(() {
                        var year = date.year.toString();
                        var month = date.month.toString();
                        var day = date.day.toString();
                        String fullData = '$year-$month-$day';
                        choiceDay = fullData;
                      });
                        //print('change $date in time zone ${date.timeZoneOffset.inHours}');
                      }, onConfirm: (date) {
                        //print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  '$choiceDay',
                  style: TextStyle(color: Colors.blue),
                )
            )),
            Expanded(child: Text('Choice hour :')),
            Expanded(
              // child: Text('$startTime'))
              child: DropdownButton<String>(
                value: firstElementList,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    firstElementList = value!;
                  });
                },
                items: hourList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ]),
          Expanded(
            child: TextField(
              controller: _eventName,
              decoration: const InputDecoration(hintText: 'enter Event Name'),
            ),
          ),
          Expanded(child: TextButton(
            onPressed: () {getStartEventFullDate();},
            child: Text('Test'),
          ))
        ]),
      ));
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
