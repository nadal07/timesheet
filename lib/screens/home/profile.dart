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
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
              onPressed: () async{
                  Navigator.of(context)
                    .pop();
                  await _auth.signOut();

              }
            )
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
