import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/models/user.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/shared/loading.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  var x;

  @override
  Widget build(BuildContext context)  {
    final users = Provider.of<MyUser>(context);
    print("hiiiiiiiiiiiiii");
    return FutureBuilder(
        future: getUserInfo(users.uid),
        builder: (context, projectSnap){
          print("i am here find me");
          if (projectSnap.hasData) {
            x = projectSnap.data;
            return Container(
                child: Form(
                  child: Column(children: <Widget>[
                    ListTile(
                      title: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          
                        ),
                      ),
                      subtitle: Text(
                        x['name'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'id',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          
                        ),
                      ),
                      subtitle: Text(
                        x['userId'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color:  Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Project',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          
                        ),
                      ),
                      subtitle: Text(
                        x['project'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color:  Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],),


                )
            );
          }
          return Loading();
        },
    );
  }
}

Future getUserInfo(String oid) async {
  return await DatabaseService().getUserData(oid);
}