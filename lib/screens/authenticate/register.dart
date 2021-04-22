import 'package:flutter/material.dart';
import 'package:timesheet/services/auth.dart';
import 'package:timesheet/shared/constants.dart';
import 'package:timesheet/shared/loading.dart';
import 'package:toast/toast.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = "";
  String email = "";
  String password = "";
  String error = "";
  String uid = "";
  String pname = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Add New Employee'),
      ),
      body: ListView(
          children: [Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
          child: Form(
            key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Enter a Name' : null,
                    onChanged: (val){
                      setState(() => name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'UserId'),
                    validator: (val) => val.isEmpty ? 'Enter an id' : null,
                    onChanged: (val){
                      setState(() => uid = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Project Name'),
                    validator: (val) => val.isEmpty ? 'Enter Project Name' : null,
                    onChanged: (val){
                      setState(() => pname = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    //color: Colors.deepOrange,
                      child: Text("Register",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          setState(()=> loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, uid, pname);
                          if (result == null){
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });
                          } else {
                            showToast("SUCCESS!!!");
                            Navigator.of(context)
                            .pop();
                          }
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))
      ),
          ])
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: Toast.BOTTOM);
  }
}
