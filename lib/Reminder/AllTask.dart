import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import 'utils/dbmanager.dart';

class AllTask extends StatefulWidget {
  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final DbTaskManager dbmanager = DbTaskManager();

  Task task;
  List<Task> taskList;
  List<Task> taskList2;
  List<Task> taskList3;
  int updateIndex;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            flexibleSpace: Positioned(
                child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hey there',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "what's your plan?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )),
            bottom: TabBar(
              unselectedLabelColor: Colors.blue,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
              tabs: <Widget>[
                Tab(
                  text: '1-3 Days',
                ),
                Tab(
                  text: '3-7 Days',
                ),
                Tab(
                  text: '>7 Days',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Padding(
            //tab1
            padding: EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: dbmanager.getTaskList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          taskList = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: taskList == null ? 0 : taskList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Task tsk = taskList[index];
                              return Card(
                                color: Colors.grey[100],
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
                                                  fontSize: 10,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.done),
                                          onPressed: () {
                                            dbmanager
                                                .updateTask(tsk)
                                                .then((id) => {});
                                            print('${tsk.done}');
                                          })
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
          Padding(
            //tab2
            padding: EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: dbmanager.getTaskListMorethan3days(),
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
                                                  fontSize: 10,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.done),
                                          onPressed: () {
                                            dbmanager
                                                .updateTask(tsk)
                                                .then((id) => {});

                                            print('${tsk.done}');
                                          })
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
          Padding(
            //tab3
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                    future: dbmanager.getTaskListMorethan7days(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        taskList = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: taskList == null ? 0 : taskList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Task tsk = taskList[index];
                            return Card(
                              color: Colors.grey[100],
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
                                                fontSize: 10,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.done),
                                        onPressed: () {
                                          dbmanager
                                              .updateTask(tsk)
                                              .then((id) => {});
                                          print('${tsk.done}');
                                        })
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return new CircularProgressIndicator();
                    }),
              ),
            ),
          ),
        ]),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                SizedBox(width: 30.0),
                IconButton(
                  color: Colors.orange[300],
                  icon: Icon(
                    Icons.archive,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/archive');
                  },
                ),
                Spacer(),
                IconButton(
                  color: Colors.blue[300],
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 30.0),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[300],
          child: Icon(
            Icons.add,
            color: Colors.blue[100],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/addTask');
          },
        ),
      ),
    );
  }
}
