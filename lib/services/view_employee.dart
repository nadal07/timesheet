import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/services/employee_details.dart';
import 'package:timesheet/shared/loading.dart';

class ViewEmployee extends StatefulWidget {
  @override
  _ViewEmployeeState createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  List<ListTile> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('TimeSheet Manager'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Loading()
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data.docs);
                    print(snapshot.data.metadata);
                    DocumentSnapshot data = snapshot.data.docs[index];
                    Map<String, dynamic> getDocs = data.data();
                    print("##############");
                    print(data.toString());
                    return _getListItemTile(context, getDocs);
                  });
        },
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
          leading: Icon(Icons.person
            
          ),
          trailing: Icon(
            Icons.arrow_right
          ),
          title: Text(getDocs['name'],
          style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold),),
          contentPadding: EdgeInsets.only(left: 5, right: 5),
        ),
      ),
    );
  }

  _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 400, 100, 400),
      items: [
        PopupMenuItem(child: Text("edit"), value: 0),
        PopupMenuItem(child: Text("delete"), value: 1),
      ],
      elevation: 8.0,
    );
  }
}
