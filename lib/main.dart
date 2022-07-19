import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

//Pages
import 'SideMenu/profile.dart';
import 'SideMenu/saved_files.dart';
import 'SideMenu/help&support.dart';
import 'SideMenu/feedback.dart';
import 'SideMenu/disclaimer.dart';
import 'gridboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetEase',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[300],
        accentColor: Colors.lightBlue[100],
      ),
      home: MyHomePage(title: 'Welcome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = ' '}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFa4def4),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(Icons.notification_important),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
      appBar: new AppBar(
        title: new Text('MeetEase', style: TextStyle(color: Color(0xff123456))),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new ListTile(
              title: new Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new ProfilePage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Saved Files'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new SavedFilesPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Help & Support'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new Help_SupportPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Feedback'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new FeedbackPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Disclaimer'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new DisclaimerPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
