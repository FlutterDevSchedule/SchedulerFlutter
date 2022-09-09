import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'calendar_add_event.dart';
import 'calendar_event_list.dart';
import 'main.dart';
import 'inserted_component.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'calendar_controller.dart';



List<String> hourList = GetCalendarData.generateTimeList();

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
  GetCalendarData getData = GetCalendarData();
  String _string = "not set yet";
  set string(String val) =>{
    print(_string),
    };
  final controller = TextEditingController();
  _test(){
    print('wywołano po dodanou');
    return null;
  }
  void initState(){
    super.initState();
    // controller.addListener(_test);
  }
  summaryEvent(startTime, timeStamp){
    DateTime start = getStartEventFullDate();
    var endTime = start.add(Duration(minutes: timeStamp));
    return endTime;
  }

  int meetingTimeRange = 0;
  // AddEventToCallendar addToCallendar = AddEventToCallendar();
  ImportElement elementTest = ImportElement();
  EventManagment eventManagment = EventManagment();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  String choiceDay = 'Set Day';
  String firstElementList = hourList.first;

  getStartEventFullDate() {
    print('$choiceDay $firstElementList');
    startTime = DateTime.parse('$choiceDay $firstElementList');

    return startTime;

  }

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
                        var month = (date.month < 10 ? '0${date.month.toString()}': date.month.toString());
                        var day = (date.day < 10 ? '0${date.day.toString()}': date.day.toString());
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
            ),
            Expanded(child: Text('$endTime')),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              BsButton(
                margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 15;

                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });
                },
                style: BsButtonStyle.success,
                label: Text('15 min'),
              ),
              BsButton(
                margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 30;
                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });

                },
                style: BsButtonStyle.success,
                label: Text('30 min'),
              ),
              BsButton(
                margin:
                EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 45;
                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });
                },
                style: BsButtonStyle.success,
                label: Text('45 min'),
              ),

              BsButton(
                margin:
                EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 60;
                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });
                },
                style: BsButtonStyle.success,
                label: Text('1 h'),
              ),
              BsButton(
                margin:
                EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 90;
                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });
                },
                style: BsButtonStyle.success,
                label: Text('1:30 h'),
              ),
              BsButton(
                margin:
                EdgeInsets.only(right: 10.0, bottom: 10.0),
                onPressed: () {
                  setState(() {
                    meetingTimeRange = 120;
                    endTime = summaryEvent(startTime, meetingTimeRange);
                  });
                },
                style: BsButtonStyle.success,
                label: Text('2 h'),
              ),
            ],
          ),
          Expanded(
            child: TextField(
              controller: _eventName,
              decoration: const InputDecoration(hintText: 'enter Event Name'),
            ),
          ),

          Column(
              children: <Widget>[
                BsButton(
                  margin:
                  EdgeInsets.only(right: 10.0, bottom: 10.0),
                  onPressed: () {
                    var eventName = _eventName.text;

                    if(eventName == ''){
                      eventName = 'Meeting';
                    }
                    new AddEventToCallendar((val) => setState(() =>  {})).calendarInser(eventName, startTime, endTime, widget.user );
                    // AddEventToCallendar.calendarInser(title, startTime, endTime, user, click)
                    // AddEventToCallendar:(){


                    // AddEventToCallendar.calendarInser(eventName, startTime, endTime, widget.user );
                    Navigator.pop(context, 'OK');
                  },
                  style: BsButtonStyle.outlinePrimary,
                  label: Text('Add Event'),
                ),
              ]
          ),

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
