import 'package:flutter/material.dart';
import 'models/record.dart';
import 'package:intl/intl.dart';

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
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              key: ValueKey(records[index]),
              child: ListTile(
                leading: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      records[index].amount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                title: Text(
                  records[index].name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  DateFormat.MMMMd().format(records[index].date),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteRecord(records[index].name),
                ),
              ),
            );
          },
        ));
  }
}
