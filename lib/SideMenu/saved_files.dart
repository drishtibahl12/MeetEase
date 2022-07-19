import "package:flutter/material.dart";
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class SavedFilesPage extends StatefulWidget {
  @override
  _SavedFilesPageState createState() => _SavedFilesPageState();
}

class _SavedFilesPageState extends State<SavedFilesPage> {
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/notes.txt';

    return filePath;
  }

  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();
    print(fileContent);
  }

  void openFile() async {
    OpenFile.open("${await getFilePath()}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Files'),
        ),
        body: ListView(
          children: [
            GestureDetector(
              child: Text("notes.txt"),
              onTap: () {
                openFile();
              },
            )
          ],
        ));
  }
}
