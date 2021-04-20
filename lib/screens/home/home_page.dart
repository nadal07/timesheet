import 'package:flutter/material.dart';
import 'package:timesheet/screens/authenticate/register.dart';
import 'package:timesheet/services/view_employee.dart';

class AdminHome extends StatefulWidget {
  final String userName;
  const AdminHome(this.userName);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: SafeArea(
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 200,
                width: 350,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Text(
                        'Good Evening',
                        style: TextStyle(fontSize: 12.0, color: Colors.black87),
                      ),
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent[400]),
                    )
                  ],
                ),
              ),
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("ADD HOLIDAYS"),
                              getSub('Add public holidays only.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => Register()
                          )
                      );
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("ADD EMPLOYEE"),
                              getSub('Add new employee.           '),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => ViewEmployee()
                          )
                      );
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("VIEW EMPLOYEE"),
                              getSub('View registered employee.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("VIEW ATTENDENCE"),
                              getSub('View employee attendence.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

Widget getTitle(String subName) {
  return Padding(
    padding: EdgeInsets.only(top: 20, left: 10, right: 60, bottom: 5.0),
    child: Text(subName,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
  );
}

// Get Sub Name
Widget getSub(String venue) {
  return Padding(
    padding: EdgeInsets.only(left: 0, bottom: 5.0),
    child: Text(venue),
  );
}
