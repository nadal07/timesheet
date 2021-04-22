import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/screens/home/profile.dart';
import 'package:timesheet/services/auth.dart';
import 'package:timesheet/services/database.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/screens/home/userlist.dart';
import 'package:intl/intl.dart';
import 'package:timesheet/models/user.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:timesheet/shared/loading.dart';
import 'package:path_provider/path_provider.dart';

class HomePage1 extends StatefulWidget {
  final String userName;
  const HomePage1(this.userName);
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  String dropdownValue = 'Current Week';
  String olddropdownValue = 'Current Week';
  String userID;
  bool notloaded = true;
  File jsonFile;
  Directory dir;
  String fileName = "data.json";
  bool fileExists = false;
  var mydata;
  List<TextEditingController> _controllers2 = new List();
  List<TextEditingController> _controllers1 = new List();

  @override
  void initState() {
    super.initState();
    //_controllers.add(new TextEditingController(text: '00:00'));

    for (var i = 0; i < 7; i++) {
      _controllers2.add(new TextEditingController(text: '00:00'));
    }
    for (var i = 0; i < 7; i++) {
      _controllers1.add(new TextEditingController(text: '00:00'));
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < 7; i++) {
    _controllers1[i].dispose();
    _controllers2[i].dispose();
    }
    super.dispose();
  }

  List<String> date_list = List(7);
  List<bool> selected = [true, true, true, true, true, false, false];

  /*
  setSelectedRadio(int val, int index){
    setState(() {
      selected[index] = val;
    });
  }*/
  
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<MyUser>(context);
    getData(users.uid);
    print("ooooo");
    print(widget.userName);
    if (dropdownValue == 'Current Week'){
      currentWeekDateRange();
    } else {
      previousWeekDateRange();
    }
    print("^^^^^^^^^^^^^");
    print(dropdownValue);
    print(olddropdownValue);
    if (dropdownValue != olddropdownValue){
      print("########");
      notloaded = true;
    }
    olddropdownValue = dropdownValue;
    //String dropdownValue = '${date_list[0]} - ${date_list[6]}';

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: Scaffold(
          backgroundColor: Colors.blue[200],
          appBar: AppBar(
            title: Text('TimeSheet Manager'),
            backgroundColor: Colors.blue[400],
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
          body: Column(
            children: [
            DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              print(newValue);
              setState(() {
                olddropdownValue = dropdownValue;
                dropdownValue = newValue;
                
              });
            },
            items: <String>['Current Week', 'Previous Week']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        Expanded(
           child: FutureBuilder(
            future: DatabaseService().getAttendanceDetails(date_list, widget.userName),
            builder: (context, snapshot){
              mydata = snapshot.data;
              print(snapshot.data);
              if (mydata != null && mydata[date_list[0].toString()] != null){
                
                //var mydata = json.decode(snapshot.data.toString());
                print("hello");
                print(date_list[0].toString());
                print(mydata[date_list[0].toString()]['log_out']);
                if (notloaded){
                  for (var i = 0; i < 7; i++) {
                    _controllers2[i].text = mydata[date_list[i].toString()]['log_out'];
                    _controllers1[i].text = mydata[date_list[i].toString()]['log_in'];

                  }
                }
                notloaded = false;
                
                mydata[date_list[0].toString()]['outTime'] = "23:10";
                return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: date_list.length,
                      itemBuilder: (BuildContext context, int index) {
                        //textFieldControllers[index] = new TextEditingController() ;
                        //_controllers.add(new TextEditingController(text: '00:00'));
                        return Card(
                            child : ListTile(
                              title: Text('${date_list[index]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blueAccent,
                                ),),
                              subtitle: Row(
                                  children: [
                                    IconButton(
                                      icon: new Icon(Icons.laptop),
                                      color: Colors.black26,
                                      onPressed: () {
                                        if (selected[index]){
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                          .then((selectedTime1) {
                                        
                                        if(selectedTime1!=null){
                                          //textFieldControllers[index].text = selectedTime.toString().substring(10, 15);
                                          mydata[date_list[index].toString()]['log_in'] = selectedTime1.toString().substring(10, 15);
                                          _controllers1[index].text = selectedTime1.toString().substring(10, 15);
                                          print("i am here");
                                          print(selectedTime1);
                                          setState(()
                                          {
                                          //_controller.text = selectedTime.toString().substring(10, 15);
                                          print(selectedTime1.toString().substring(10, 15));
                                          //_inTime = selectedTime.toString().substring(10, 15);
                                          });
                                        }
                                      });}},
                                    ),
                                    Container(
                                        width: 50.0,
                                        height: 48.0,
                                        child: TextField(
                                          readOnly: !selected[index],
                                            controller: _controllers1[index],
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black
                                            )
                                        )
                                    ),
                                    IconButton(
                                      icon: new Icon(Icons.time_to_leave),
                                      color: Colors.black26,
                                      onPressed: () {
                                        if (selected[index]){

                                        
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                          .then((selectedTime) {
                                        
                                        if(selectedTime!=null){
                                          //textFieldControllers[index].text = selectedTime.toString().substring(10, 15);
                                          _controllers2[index].text = selectedTime.toString().substring(10, 15);
                                          mydata[date_list[index].toString()]['log_out'] = selectedTime.toString().substring(10, 15);
                                          print("i am here");
                                          print(selectedTime);
                                          setState(()
                                        {
                                          //_controller.text = selectedTime.toString().substring(10, 15);
                                          print(selectedTime.toString().substring(10, 15));
                                          //_inTime = selectedTime.toString().substring(10, 15);
                                        });
                                        }
                                      });}},
                                    ),
                                    Container(
                                        width: 50.0,
                                        height: 48.0,
                                        child: TextField(
                                            readOnly: !selected[index],
                                            controller: _controllers2[index],
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                height: 2.0,
                                                color: Colors.black
                                            )
                                        )
                                    )]
                              ),
                              trailing: Checkbox(
                                value: selected[index],
                                
                                activeColor: Colors.blue,
                               onChanged: (val){
                                 print("pressed");
                                //setSelectedRadio(val, index);
                                setState(() {
                                  selected[index] = val;
                                });
                                
                                 
                               },
                              ),
                            )
                        );
                      }

                  );}
                return Loading();
            }
            
            ))

            ],
          ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          sendData();
        },
        label: const Text('Send'),
        icon: const Icon(Icons.send),
        backgroundColor: Colors.pink,
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
      String mid1 = '-0';
      String mid2 = '-0';
      if (dates.month > 9){
        mid1 = '-';
      }
      if (dates.day > 9){
        mid2 = '-';
      }
      date_list[i] = dates.year.toString()+mid1+dates.month.toString()+mid2+dates.day.toString();
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
      String mid1 = '-0';
      String mid2 = '-0';
      if (dates.month > 9){
        mid1 = '-';
      }
      if (dates.day > 9){
        mid2 = '-';
      }
      date_list[i] = dates.year.toString()+mid1+dates.month.toString()+mid2+dates.day.toString();
    }
    for (int i=0; i< 7;i++){
      print(date_list[i]);
    }
    print("picka");
    var lastDayOfWeek = firstDayOfPreviousWeek.add(Duration(days: 6));
    print(lastDayOfWeek);
    for (var i = 0; i < 7; i++) {
      _controllers2[i].text = "00:00";
    }
    return 0;
  }
  void sendData(){
    print("hii ho");
    DocumentReference fstore = FirebaseFirestore.instance.collection('attendence').doc('data');
    for (int i = 0;i < 7; i++){
      fstore.collection(date_list[i]).doc(userID).set({
          "log_in": _controllers1[i].text,
          "log_out": _controllers2[i].text,
          "on_leave": "false",
    }).then((_){
      showToast("Success");
      print("success");
    });
    }
  }

  Future getData(users) async{
    String x;
    DocumentReference fs = FirebaseFirestore.instance.collection('users').doc(users);
    await fs.get().then((value) {
      print(value.data());
      x = value.data()['userId'];
      userID = x;
      print(x);
    });
    return x;
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: Toast.BOTTOM);
  }
}
