import 'package:flutter/material.dart';

import 'AllTask.dart';
import 'Arsip.dart';
import 'tambahTask.dart';

class Reminder extends StatelessWidget {
  // This widget is the root of your application.
  //Task task;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => AllTask(),
        '/addTask': (context) => MyHomePage(),
        '/archive': (context) => MyArchive(),
      },
    );
  }
}
