// import the Dart package needed for all Flutter apps
import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  final Map<String, dynamic> person;
  final Map<String, Color> _color = {
    "nice": Color.fromRGBO(220, 255, 220, 1.0),
    "naughty": Color.fromRGBO(255, 220, 220, 1.0),
  };

  Person({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    Color? color = _color[person['status']];
    return Container(
      child: Text(
        "${person['first']} ${person['last']}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
          color: color, border: Border.all(color: Colors.blue, width: 2)),
    );
  }
}
