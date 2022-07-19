import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/dbmanager.dart';

class MyArchive extends StatefulWidget {
  @override
  _MyArchiveState createState() => _MyArchiveState();
}

class _MyArchiveState extends State<MyArchive> {
  final DbTaskManager dbmanager = DbTaskManager();
  List<Task> taskList;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Arsip'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: FutureBuilder(
                  future: dbmanager.getArsip(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      taskList = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskList == null ? 0 : taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Task tsk = taskList[index];
                          return Card(
                            color: Colors.blue[100],
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${tsk.task}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${DateFormat("MMMM dd").format(DateTime.parse(tsk.date)).toString()} Jam ${DateFormat("HH:mm").format(DateTime.parse(tsk.date)).toString()}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // IconButton(
                                  //     icon: Icon(Icons.done),
                                  //     onPressed: () {
                                  //       dbmanager.updateTask(tsk).then((id)=>{

                                  //       });
                                  //       print('${tsk.done}');
                                  //     })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return new CircularProgressIndicator();
                  }),
            )),
      ),
    );
  }
}
