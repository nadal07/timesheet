import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/screens/home/profile.dart';
import 'package:timesheet/services/auth.dart';
import 'package:timesheet/services/database.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/screens/home/userlist.dart';
import 'package:intl/intl.dart';
import 'package:timesheet/services/fillsheet.dart';

class timesheet extends StatefulWidget {
  List<String> date_list = List(7);
  @override
  _timesheetState createState() => _timesheetState();
}

class _timesheetState extends State<timesheet> {
  List<String> date_list = List(7);
  @override
  Widget build(BuildContext context) {
    daterange();
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('TimeSheet Manager'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                  onPressed: () {
                    print("pressed");
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(
                            builder: (context) => Profile()
                        )
                    );
                  }
              )
            ],
          ),
          body: FillSheet(),

      ),
    );
  }



int daterange(){
  final date = new DateTime.now();
  print(date.weekday.toString());
  final startOfYear = new DateTime(date.year, 1, 1, 0, 0);
  print(startOfYear.weekday.toString());
  print(startOfYear.day.toString());
  final firstMonday = startOfYear.weekday;
  print(firstMonday.toString());
  final daysInFirstWeek = 8 - firstMonday;
  print(daysInFirstWeek.toString());
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
  int week = weeks;
  print("Start Date for week $week: ${startOfYear.add(Duration(days: 7*week))}");
  print("End Date for week $week: ${startOfYear.add(Duration(days: 7*week+6))}");

  var d = DateTime.now();
  var weekDay = d.weekday;
  var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
  print("hello");
  for (int i = 0; i< 7; i++){
    var dates = firstDayOfWeek.add(Duration(days: i));
    date_list[i] = dates.year.toString()+"/"+dates.month.toString()+'/'+dates.day.toString();
  }
  for (int i=0; i< 7;i++){
    print(date_list[i]);
  }
  print("wello");
  var lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  print(lastDayOfWeek);

  return 0;
}
}

