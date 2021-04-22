import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/services/employee_details.dart';
import 'package:timesheet/shared/loading.dart';

class ViewAttendence extends StatefulWidget {
  @override
  _ViewAttendenceState createState() => _ViewAttendenceState();
}

class _ViewAttendenceState extends State<ViewAttendence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('View Attendence'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 100,
                child: Container(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.folder_sharp))),
              ),
              SizedBox(
                width: 40,
              ),
              SizedBox(
                  height: 30,
                  width: 100,
                  child: Container(
                      color: Colors.blue[400],
                      child: Center(
                        child: Text(
                          "Not Sent",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ))),
              SizedBox(
                width: 40,
              ),
              SizedBox(
                height: 30,
                width: 100,
                child: Container(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.save_sharp))),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
                future: DatabaseService().getAttendenceDetails('2021-4-19'),
                builder: (context, snapshot) {
                  List<DocumentSnapshot> ds = snapshot.data;
                  if (snapshot.data != null) {
                    return Container(
                        child: ListView.builder(
                            itemCount: ds.length,
                            itemBuilder: (context, index) {
                              print(snapshot.data[index]['name']);
                              DocumentSnapshot data = snapshot.data[index];
                              Map<String, dynamic> getDocs = data.data();
                              print("##############");
                              print(data.toString());
                              return Container(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _getListItemTile(context, getDocs),
                                ],
                              ));
                            }));
                  }
                  return Loading();
                }),
          ),
        ],
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, Map getDocs) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EmployeeDetails(getDocs)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.only(left: 5, right: 5),
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.person),
          trailing: Icon(Icons.arrow_right),
          title: Text(
            getDocs['name'],
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.only(left: 5, right: 5),
        ),
      ),
    );
  }
}
