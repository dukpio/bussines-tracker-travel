import 'package:flutter/material.dart';
import './record.dart';

class ListofRecords extends StatelessWidget {
  final List<Record> records = [
    Record(
      amount: 25.99,
      date: DateTime(2022, 9, 7),
      nameofTransaction: 'Taxi to the Airport',
    ),
    Record(
      amount: 89.99,
      date: DateTime(2022, 9, 5),
      nameofTransaction: 'Airplane ticket',
    ),
    Record(
      amount: 30.89,
      date: DateTime(2022, 9, 6),
      nameofTransaction: 'Gow',
    ),
  ];

  ListofRecords(records);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              key: ValueKey(records[index]),
              child: FittedBox(child: Text(records[index].toString())),
            );
          }),
    );
  }
}
