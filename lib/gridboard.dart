import 'package:flutter/material.dart';
import 'package:meet_ease/Reminder/AllTask.dart';
import 'package:meet_ease/Reminder/home.dart';
import 'package:meet_ease/VoiceRecorder/speech_screen.dart';
import 'Reminder/Arsip.dart';
import 'Reminder/tambahTask.dart';
import 'ToDoList/Screens/tasks/tasks.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  Items item1 = new Items(
      title: "Record",
      subtitle: "    Tap to convert your speech",
      event: "into text ",
      img: "asset/mic.png");

  Items item2 = new Items(
    title: "To Do List",
    subtitle: " ",
    event: " ",
    img: "asset/notes.png",
  );

  Items item3 = new Items(
    title: "Upload",
    subtitle: "",
    event: "",
    img: "asset/upload.png",
  );

  Items item4 = new Items(
    title: "Reminder",
    subtitle: "Hey there, what's your plan?",
    event: "",
    img: "asset/calendar.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xff42d8ff;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            print(data);
            return GestureDetector(
              onTap: () {
                if (data.title.toLowerCase() == "to do list") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Tasks();
                  }));
                } else if (data.title.toLowerCase() == "record") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SpeechScreen();
                  }));
                } else if (data.title.toLowerCase() == "reminder") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Reminder();

                    //return '/addTask': (context) => MyHomePage(),
                    //return '/archive';: (context) => MyArchive(),
                  }));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
