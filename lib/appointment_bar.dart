import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class AppoitmentBar extends StatefulWidget {
  const AppoitmentBar({Key? key}) : super(key: key);

  @override
  State<AppoitmentBar> createState() => _AppoitmentBarState();
}

class _AppoitmentBarState extends State<AppoitmentBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.day,
          // dataSource: MeetingDataSource(_getDataSource()),
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }
}
