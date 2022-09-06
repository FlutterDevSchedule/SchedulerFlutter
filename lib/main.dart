
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'logged_in_page.dart';
import 'sheduler_main_layout.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: Icon(
                  Icons.favorite,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                onPressed: singIn,
                label: Text('sing up with google'))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future singIn() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('sing in failed')));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MainLayout(user: user)));
    }
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(scopes: [CalendarApi.calendarScope]);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

