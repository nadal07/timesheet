import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timesheet/services/create_excel.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/services/employee_details.dart';
import 'package:timesheet/shared/loading.dart';
import 'package:filesystem_picker/filesystem_picker.dart';

class ViewAttendence1 extends StatefulWidget {
  @override
  _ViewAttendence1State createState() => _ViewAttendence1State();
}

class _ViewAttendence1State extends State<ViewAttendence1> {
  String dropdownValue = 'Current Week';
  String path = '/storage/emulated/0/Documents';
  List<String> date_list = List(7);
  @override
  Widget build(BuildContext context) {
    if (dropdownValue == 'Current Week'){
      currentWeekDateRange();
    } else {
      previousWeekDateRange();
    }
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('View Attendence'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward_sharp),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blue[800],
            ),
            onChanged: (String newValue){
              print(newValue);
              setState(() {
                dropdownValue = newValue;
              });
              
            },
            items: <String>['Current Week', 'Previous Week']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );}).toList()
            ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 100,
                child: Container(
                    child: IconButton(
                        onPressed: () async {
                          Directory  rootPath = await getExternalStorageDirectory();
                          String temp = await FilesystemPicker.open(
                            title: 'Save to folder',
                            context: context,
                            rootDirectory: rootPath,
                            fsType: FilesystemType.folder,
                            pickText: 'Save file to this folder',
                            folderIconColor: Colors.teal,
                          );
                          if (temp != "null"){
                            path = temp;
                          }
                          print(path);
                        },
                        icon: Icon(Icons.folder_sharp))),
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
                        onPressed: () async{
                          print(path);
                          await GenExcel().create(date_list, path);
                          print("done");
                        }, icon: Icon(Icons.save_sharp))),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
                future: DatabaseService().getAttendenceDetails(date_list[0]),
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
  int currentWeekDateRange(){
    var d = DateTime.now();
    var weekDay = d.weekday;
    var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
    print("hello");
    for (int i = 0; i< 7; i++){
      var dates = firstDayOfWeek.add(Duration(days: i));
      date_list[i] = dates.year.toString()+"-"+dates.month.toString()+'-'+dates.day.toString();
    }
    for (int i=0; i< 7;i++){
      print(date_list[i]);
    }
    print("wello");
    var lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    print(lastDayOfWeek);
    /*
    for (var i = 0; i < 7; i++) {
      _controllers[i].text = "00:00";
    }*/
    return 0;
  }
  int previousWeekDateRange(){
    var d = DateTime.now();
    var weekDay = d.weekday;
    var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
    var firstDayOfPreviousWeek = firstDayOfWeek.subtract(Duration(days: 7));
    print("hello");
    for (int i = 0; i< 7; i++){
      var dates = firstDayOfPreviousWeek.add(Duration(days: i));
      date_list[i] = dates.year.toString()+"-"+dates.month.toString()+'-'+dates.day.toString();
    }
    for (int i=0; i< 7;i++){
      print(date_list[i]);
    }
    print("picka");
    var lastDayOfWeek = firstDayOfPreviousWeek.add(Duration(days: 6));
    print(lastDayOfWeek);
    return 0;
  }
}
