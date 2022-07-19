import "package:flutter/material.dart";

class Help_SupportPage extends StatefulWidget {
  @override
  _Help_SupportPageState createState() => _Help_SupportPageState();
}

class _Help_SupportPageState extends State<Help_SupportPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Help & Support')),
      body: Text(
          "Contact us for any support or help you need in the working of the application. We're at your service at all times."
          "Our mail id - meetease21@gmail.com"),
    );
  }
}
