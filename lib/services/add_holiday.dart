import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddHoliday extends StatefulWidget {
  @override
  _AddHolidayState createState() => _AddHolidayState();
}

class _AddHolidayState extends State<AddHoliday> {
  TextEditingController namecontroller;
  String dateFormat(DateTime dates){
    String mid1 = '-0';
      String mid2 = '-0';
      if (dates.month > 9) {
        mid1 = '-';
      }
      if (dates.day > 9) {
        mid2 = '-';
      }
      String dateList = dates.year.toString() +
          mid1 +
          dates.month.toString() +
          mid2 +  
          dates.day.toString();
      return dateList;
  }

  @override
  void initState() {
    var dates = DateTime.now();
    String dateList = dateFormat(dates);
    
    namecontroller = new TextEditingController(text: dateList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Add Holiday'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                SizedBox(
                            width: 150,
                            child: TextField(
                              
                              controller: namecontroller
                            ),
                          ),
                IconButton(icon: Icon(Icons.calendar_today), onPressed: (){
                  showDatePicker(context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2222)).then((date){
                    setState(() {
                      namecontroller.text = dateFormat(date);
                    });
                  });

                })
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: ElevatedButton(onPressed: (){
              sendData();
            },
            child: Text("Send")))
          ],),
        
      ),
    );
  }
  void sendData() async{
    print("hii ho");
    var snapTotalUser = await FirebaseFirestore.instance.collection('users')
    .where('access', isEqualTo: 'non-admin')
    .get();
    DocumentReference fstore =
        FirebaseFirestore.instance.collection('attendence').doc('data');
     snapTotalUser.docs.forEach((element) {
        fstore.collection(namecontroller.text).doc(element.data()['userId']).set({
        "log_in": "00:00",
        "log_out": "00:00",
        "on_leave": "yes",
        "remark":"holiday"
        }).then((_) {
          showToast("Success");
          print("success");
        });
     });
  }
void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: Toast.BOTTOM);
  }
}