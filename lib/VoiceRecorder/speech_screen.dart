import "package:avatar_glow/avatar_glow.dart";
import "package:flutter/material.dart";
import "package:highlight_text/highlight_text.dart";
import 'package:open_file/open_file.dart';
import "package:speech_to_text/speech_to_text.dart" as stt;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

//import 'package:syncfusion_flutter_pdf/pdf.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/notes.txt';
    return filePath;
  }

  void saveFile(note) async {
    File file = File(await getFilePath());
    file.writeAsString(note);
    print(file);
  }

  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();

    print('File Content: $fileContent');
  }


  Future<void> _createPDF(text) async {
    //Create a PDF document.
    var document = PdfDocument();
    //Add page and draw text to the page.
    document.pages.add().graphics.drawString(
        text, PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 500, 30));
    //Save the document
    var bytes = document.save();
    // Dispose the document
    document.dispose();

    //Get external storage directory
    Directory directory = await getExternalStorageDirectory();
//Get directory path
    String path = directory.path;
//Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);
//Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(seconds: 10),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: TextHighlight(
                text: _text,
                words: _highlights,
                enableCaseSensitive: true,
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                saveFile(_text);
                readFile();
                _createPDF(_text);
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
        finalTimeout: Duration(seconds: 10),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
