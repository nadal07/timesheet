import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/services/auth.dart';
import 'package:timesheet/services/database.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/screens/home/userlist.dart';

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          
        ),
        body: UserList(),
      ),
    );
  }
}
