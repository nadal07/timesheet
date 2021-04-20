import 'package:flutter/material.dart';

class FillSheet extends StatefulWidget {
  @override
  _FillSheetState createState() => _FillSheetState();
}

class _FillSheetState extends State<FillSheet> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
              label: Text(
                'Date')),
          DataColumn(
              label: Text(
                  'InTime')),
        DataColumn(
            label: Text(
                'OutTime')),],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Sarah')),
              DataCell(Text('19')),
              DataCell(Text('Student')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Janine')),
              DataCell(Text('43')),
              DataCell(Text('Professor')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('William')),
              DataCell(Text('27')),
              DataCell(Text('Associate Professor')),
            ],
          ),
        ],
    );
  }
}
