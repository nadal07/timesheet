import 'package:flutter/material.dart';
import 'package:timesheet/screens/authenticate/register.dart';
import 'package:timesheet/screens/home/home_page_reading_from_json.dart';
import 'package:timesheet/services/add_holiday.dart';
import 'package:timesheet/services/add_leave.dart';
import 'package:timesheet/services/auth.dart';
import 'package:timesheet/services/try.dart';
import 'package:timesheet/services/view_attendenc.dart';
import 'package:timesheet/services/view_employee.dart';

class EmpHome extends StatefulWidget {
  final String userName;
  final String userId;
  const EmpHome(this.userName, this.userId);
  @override
  _EmpHomeState createState() => _EmpHomeState();
}

class _EmpHomeState extends State<EmpHome> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/home_page.jpeg"),
                fit: BoxFit.fill
              ),
            ),
            child: Column(children: [
              Container(
                child: Row(
                children: [
                  SizedBox(
                    width: 340
                  ),
                  IconButton(
                    onPressed: ()async{
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.logout),)
                ],)
              ),
              SizedBox(
                height: 200,
                width: 350,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Text(
                        'Welcome',
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
                      Navigator.of(context)
                      .push( MaterialPageRoute(
                              builder: (context) => AddLeave(widget.userId)
                          )
                      );
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/holi.jpg"),
                                  fit: BoxFit.fill),
                            ),
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("ADD LEAVE       "),
                              getSub('Add One leave at a time.'),
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
                              builder: (context) => HomePage1(widget.userId)
                          )
                      );
                    },
                    child: SizedBox(
                      width: 350,
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/attend.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: const SizedBox(width: 80, height: 80),
                          ),
                          Column(
                            children: [
                              getTitle("SEND TIMESHEET"),
                              getSub('Send the timesheet               '),
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
