import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/models/user.dart';
import 'package:timesheet/screens/authenticate/authenticate.dart';
import 'package:timesheet/screens/home/home.dart';
import 'package:timesheet/screens/home/home_page_reading_from_json.dart';
import 'package:timesheet/screens/home/profile.dart';
import 'package:timesheet/services/view_employee.dart';
import 'home/home_page.dart';
import 'home/timesheet.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/shared/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  var x;
  Widget build(BuildContext context) {
    //return either home or Authenticate widget
    final user = Provider.of<MyUser>(context);
    //print(user.uid);
    if  (user == null) {
      return Authenticate();
    } else {
      print(user.uid);
      return FutureBuilder(
        future: DatabaseService().getUserData(user.uid),
        builder: (context, projectSnap){
          if(projectSnap.hasData){
            x = projectSnap.data;
            if(x['access'].toString() == 'admin'){
              return AdminHome(x['name'].toString());
            } else {
              return HomePage1(x['userId'].toString());
            }
          }
          return Loading();
        });

    }

  }
}
