import 'package:flutter/material.dart';

class AddHoliday extends StatefulWidget {
  @override
  _AddHolidayState createState() => _AddHolidayState();
}

class _AddHolidayState extends State<AddHoliday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Add Holiday'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Container(
        child: Text("to do"),
      ),);
  }
}