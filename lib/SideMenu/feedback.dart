import "package:flutter/material.dart";

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Feedback')),
      body: Text(
          "All your views and opinions are valuable to us. Let us know what you think!"
          "Our mail id - meetease21@gmail.com"),
    );
  }
}
