import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_app/calendar_event_list.dart';

import 'appointment_bar.dart';
import 'logged_in_page.dart';

class MainLayout extends StatefulWidget {
  final GoogleSignInAccount user;

  const MainLayout({
    Key? key,
    required this.user,
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
                                  child: LoggedInPage(user: widget.user,),
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
                    child:AppoitmentBar()
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
