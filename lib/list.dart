import 'package:flutter/material.dart';
import './record.dart';
import 'package:intl/intl.dart';

class ListofRecords extends StatelessWidget {
  final List<Record> records = [
    Record(
      amount: 25.99,
      date: DateTime(2022, 9, 7),
      name: 'Taxi to the Airport',
    ),
    Record(
      amount: 89.99,
      date: DateTime(2022, 9, 5),
      name: 'Airplane ticket',
    ),
    Record(
      amount: 30.89,
      date: DateTime(2022, 9, 6),
      name: 'Dinner',
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
              child: ListTile(
                leading: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      records[index].amount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                ),
                title: Text(
                  records[index].name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(DateFormat.MMMMd().format(records[index].date)),
              ),
            );
          },
        ));
  }
}
