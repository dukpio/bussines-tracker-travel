import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/record.dart';

class ListofRecords extends StatelessWidget {
  final List<Record> records;
  final Function deleteRecord;

  ListofRecords(this.records, this.deleteRecord);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              key: ValueKey(records[index]),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    records[index].amount.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                title: Text(
                  records[index].name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  DateFormat.MMMMd().format(records[index].date),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteRecord(records[index].id),
                ),
              ),
            );
          },
        ));
  }
}
