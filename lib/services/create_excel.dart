import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class GenExcel {

  Future create(List<String> date, String path) async{
    var filename = date[0]+'_'+date[6]+'.xlsx';
    var excel = Excel.createExcel();
    var id;
    int count = 2;
    Sheet sheetObject = excel['EmployeePunchDetails'];
    sheetObject.insertRow(1);
    CellStyle cellStyle = CellStyle(bold: true);
    for(int i = 1; i< 3; i++){
      var cell = sheetObject.cell(CellIndex.indexByString("A"+i.toString()));
      cell.cellStyle = cellStyle;
      cell = sheetObject.cell(CellIndex.indexByString("B"+i.toString()));
      cell.cellStyle = cellStyle;
      cell = sheetObject.cell(CellIndex.indexByString("C"+i.toString()));
      cell.cellStyle = cellStyle;
      cell = sheetObject.cell(CellIndex.indexByString("D"+i.toString()));
      cell.cellStyle = cellStyle;
      cell = sheetObject.cell(CellIndex.indexByString("E"+i.toString()));
      cell.cellStyle = cellStyle;
    }


    List<String> dataList = ["EMP_CODE","WORKDATE", "INPUNCH", "OUTPUNCH", "REMARKS"];
    sheetObject.insertRowIterables(dataList, 0);
    List<String> dataList1 = ["Huawei Emp_code","yyyy-mm-dd", "hh:mm(24hrs)", "hh:mm(24hrs)", "REMARKS(max 200 characters ex: remarks)"];
    sheetObject.insertRowIterables(dataList1, 1);
    cellStyle = CellStyle(backgroundColorHex: "#DAEEF3");
    for (int i = 0; i < 7; i++){
      var snap = await FirebaseFirestore.instance.collection('attendence').doc("data").collection(date[i]).get();
      snap.docs.forEach((element) {
        List<String> perRow = new List();
        perRow.add(element.id);
        perRow.add(date[i]);
        perRow.add(element['log_in']);
        perRow.add(element['log_out']);
        perRow.add(element['remark']);
        sheetObject.insertRowIterables(perRow, count);
        count = count + 1;
        print(element.id);
        print(element['log_in']);
        print(element['log_out']);
        print(element['on_leave']);
        id = element.id;
        var cell = sheetObject.cell(CellIndex.indexByString("A"+count.toString()));
        cell.cellStyle = cellStyle;
        cell = sheetObject.cell(CellIndex.indexByString("B"+count.toString()));
        cell.cellStyle = cellStyle;
        cell = sheetObject.cell(CellIndex.indexByString("C"+count.toString()));
        cell.cellStyle = cellStyle;
        cell = sheetObject.cell(CellIndex.indexByString("D"+count.toString()));
        cell.cellStyle = cellStyle;
        cell = sheetObject.cell(CellIndex.indexByString("E"+count.toString()));
        cell.cellStyle = cellStyle;
        //names.add(id.toString());
      });
    }

    var isSet = await excel.setDefaultSheet('EmployeePunchDetails');
    if (isSet) {
        print(" is set to default sheet.");
      } else {
        print("Unable to set to default sheet.");
      }
    excel.encode().then((onValue) {
        File(join(path+"/"+filename))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });

  }
}