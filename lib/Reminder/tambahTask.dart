import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:intl/intl.dart';
import 'utils/dbmanager.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DbTaskManager dbmanager = new DbTaskManager();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static var counter = 0;

  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  DateTime selectedTgl = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  Task task;
  DateTime datepick;
  List<Task> taskList;
  int updateIndex;

// Future pickDate() async {
// datepick = await showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime(2010),
// lastDate: DateTime(2025));

// if (datepick != null)
// setState(() {
// _dateController.text =
// DateFormat("dd-MM-yyyy").format(datepick).toString();
// });
// }
  Future pickDate() async {
    final selectedDate = await _selectDateTime(context);
    if (selectedDate == null) return;
    final selectedTime = await _selectTime(context);
    if (selectedTime == null) return;

    setState(() {
      this.selectedTgl = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      _dateController.text =
          DateFormat('dd MMMM yyyy HH:mm').format(selectedTgl).toString();
      print('ini adalah tanggal : ${_dateController.text}');
      datepick = selectedTgl;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Add New Task",
          style: TextStyle(color: Colors.deepPurple),
        )),
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Enter your task',
                        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurpleAccent))),
                    controller: _nameController,
                    validator: (val) =>
                        val.isNotEmpty ? null : 'Task Should Not Be empty',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
//                   ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    onPressed: pickDate,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.blue,
                            size: 30,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            _dateController.text,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    child: Container(
                        width: width * 0.9,
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () {
                      _submitStudent(context);
                      showNotification();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitStudent(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (task == null) {
        if (_dateController.text.isEmpty) {
          _dateController.text =
              DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
          datepick = DateTime.now();
        }
        print('hasil datepick ${datepick.toString()}');
        Task st = new Task(
            task: _nameController.text, done: 0, date: datepick.toString());
        dbmanager.insertTask(st).then((id) => {
              _nameController.clear(),
              _courseController.clear(),
              _dateController.clear(),
            });
      } else {
        task.task = _nameController.text;
        task.done = 0;
        task.date = selectedTgl.toString();
        dbmanager.updateTask(task).then((id) => {
              setState(() {
                taskList[updateIndex].task = _nameController.text;
                taskList[updateIndex].done = 0;
                taskList[updateIndex].date = selectedTgl.toString();
              }),
              _nameController.clear(),
              _dateController.clear(),
              _courseController.clear(),
              task = null
            });
      }
    }
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.High, importance: Importance.Max, ticker: 'duar');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.schedule(counter, 'Don\'t forget',
        '${_nameController.text}', datepick, platform);
    counter++;
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Payload: $payload');
    }
//    await Navigator.push(
//      context,
//      new MaterialPageRoute(builder: (context) => new AllTask())
//    );
  }
}

Future<TimeOfDay> _selectTime(BuildContext context) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
  );
}

Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
