import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/shared/loading.dart';
import 'package:toast/toast.dart';

class EmployeeDetails extends StatefulWidget {
  final Map details;
  const EmployeeDetails(this.details);
  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  bool readonlyname = true;
  bool readonlyuserid = true;
  bool readonlyproject = true;
  bool readonlyaccess = true;
  List<TextEditingController> namecontroller = new List();

  @override
  void initState() {
    super.initState();
    namecontroller.add(new TextEditingController(text: widget.details['name']));
    namecontroller
        .add(new TextEditingController(text: widget.details['userId']));
    namecontroller
        .add(new TextEditingController(text: widget.details['project']));
    namecontroller
        .add(new TextEditingController(text: widget.details['access']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
              child: Container(
            child: FutureBuilder(
                future: DatabaseService().getdetails(widget.details['userId']),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.data != null) {
                    print("loookiing");
                    print(snapshot.data);
                    //namecontroller.text = widget.details['name'];
                    return Container(
                        child: Column(
                      children: [
                        Container(
                            child: SizedBox(
                          height: 100,
                        )),
                        Row(children: [
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                              width: 80,
                              child: Text("NAME",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              readOnly: readonlyname,
                              controller: namecontroller[0],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                readonlyname = false;
                              });
                            },
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                              width: 80,
                              child: Text(
                                "USER ID",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              readOnly: readonlyuserid,
                              controller: namecontroller[1],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                readonlyuserid = false;
                              });
                            },
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                              width: 80,
                              child: Text(
                                "PROJECT",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              readOnly: readonlyproject,
                              controller: namecontroller[2],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                readonlyproject = false;
                              });
                            },
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                              width: 80,
                              child: Text(
                                "ACCESS",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              readOnly: readonlyaccess,
                              controller: namecontroller[3],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                readonlyaccess = false;
                              });
                            },
                          )
                        ]),
                        SizedBox(
                          height: 100,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (readonlyname && readonlyuserid && readonlyproject && readonlyaccess){
                                  showToast("NOTHING TO UPDATE!!!");
                                } else {
                                  updateEmployeeData(snapshot.data, namecontroller[1].text, namecontroller[0].text, namecontroller[2].text, namecontroller[3].text);
                                }
                              }, child: Icon(Icons.save)),
                          SizedBox(
                            width: 150,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Icon(Icons.delete_forever))
                        ])
                      ],
                    ));
                  }
                  return Loading();
                })),
      ),
    );
  }


void updateEmployeeData(
    String eid, String userId, String name, String project, String access) {
  DocumentReference fstore =
      FirebaseFirestore.instance.collection('users').doc(eid);

  for (int i = 0; i < 7; i++) {
    fstore.update({
        'userId': userId,
        'name': name,
        'project': project,
        'access': access,
      }).then((_) {
        showToast("Success");
        print("success");
      });
  }
    }
    void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: Toast.BOTTOM);
  }
}