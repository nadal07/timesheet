import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //Collection reference\
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference attendanceCollection = FirebaseFirestore.instance.collection('attendence');

  Future updateUserData(String userId, String name, String project) async {
    return await userCollection.doc(uid).set({
      'userId' : userId,
      'name' : name,
      'project' : project,
      'access' : 'non-admin',
    });
  }

  Future getUserData(String oid) async {
    print("aaaaaaaaaaaaa");
    print(oid.toString());
    print("gggggggggggg");
    var x = await userCollection.doc(oid).get();

    print(oid);
    print(x);
    print("hhhhhhhhhhh");
    print(x.data().values);
    print(x.data());
    var map = Map.fromIterables(x.data().keys, x.data().values);
    //Map<String, dynamic> userdata = jsonDecode(x.data());
    print(map);
    print(map['name']);
    return map;
  }

  Future getAttendanceDetails(List<String> dateList, String userID) async{
    Map<String, Map> map = Map();
    Map<String, String> black = {
        "log_in":"10:00",
        "log_out":"23:59"
    };
    List<String> date = List(7);
    List<Map> data = List(7);
    for (int i = 0; i< 7;i++){
      var datesData = await attendanceCollection.doc('data').collection(dateList[i].toString()).doc(userID).get();
      //var datesData = await attendanceCollection.doc('data').get();
      print("in database");
      print(datesData.data());
      if (datesData.data() != null){
        print(datesData.data().values);
        date[i] = dateList[i].toString();
        
        Map temp = Map.fromIterables(datesData.data().keys, datesData.data().values);
        data[i] = temp;

      } else {
        date[i] = dateList[i].toString();
        data[i] = black;

      }
    }
      
    map = Map.fromIterables(date, data);
    return map;
    }
  Future getallEmployee() async{

    var snap = await FirebaseFirestore.instance.collection('users')
    .where('name', isEqualTo: "admin")
    .get();
    snap.docs.forEach((element) {
      print(element.id);
    });
    /*
    FirebaseFirestore.instance.collection('users')
    .where('name', isEqualTo: "admin")
    .get()
    .then((querySnapshot){
      querySnapshot.docs.forEach((documentSnapshot) {
        print(documentSnapshot.id);
      });
    });*/

  }

  Future getdetails(String date) async{
    var id;
    var snap = await FirebaseFirestore.instance.collection('users')
    .where('userId', isEqualTo: date)
    .get();
    print(snap);
    print(snap.size);
    snap.docs.forEach((element) {
      print(element.id);
      id = element.id;
    });

    return id;
    
    /*
    return FirebaseFirestore.instance.collection('users')
    .where('userId', isEqualTo: uid)
    .get()
    .then((querySnapshot){
      querySnapshot.docs.forEach((documentSnapshot) {
        return documentSnapshot.id;
        
      });
    });*/

  }


Future getAttendenceDetails(String date) async{
    var id;
    List<DocumentSnapshot> ds = new List();
    List<String> names = new List();
    var snapTotalUser = await FirebaseFirestore.instance.collection('users')
    .where('access', isEqualTo: 'non-admin')
    .get();
    int totalUserCount = snapTotalUser.size;

    var snap = await FirebaseFirestore.instance.collection('attendence').doc("data").collection(date)
    .get();
    print(snap);
    int totalUserSent = snap.size;
    int remainingUser = totalUserCount - totalUserSent;
    snap.docs.forEach((element) {
      print(element.id);
      id = element.id;
      names.add(id.toString());
    });
    snapTotalUser.docs.forEach((element) {
      if (!names.contains(element.data()['userId'])){
        print(element.data()['name']);
        ds.add(element);
      }
    });
    return ds;
}
  Future updateUserDataByAdmin(String eid, String userId, String name, String project, String access) async {
    return await userCollection.doc(eid).set({
      'userId' : userId,
      'name' : name,
      'project' : project,
      'access' : access,
    });
  }
  
  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

}