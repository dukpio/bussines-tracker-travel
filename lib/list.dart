import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'models/record.dart';

class ListofRecords extends StatelessWidget {
  Box travelBox = Hive.box<Record>('travel');

  ListofRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ValueListenableBuilder(
        valueListenable: travelBox.listenable(),
        builder: (context, Box<dynamic> box, _) {
          return ListView.builder(
            itemCount: travelBox.values.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                key: ValueKey(travelBox.values.toList()[index].id),
                child: ListTile(
                  leading: Card(
                    margin: const EdgeInsets.all(3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        travelBox.values
                            .toList()[index]
                            .amount
                            .toStringAsFixed(2),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  title: Text(
                    travelBox.values.toList()[index].name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    DateFormat.MMMMd()
                        .format(travelBox.values.toList()[index].date),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await travelBox.deleteAt(index);
                    },
                    // onPressed: () => deleteTransaction(
                    //     travelBox.values.toList()[index].amount),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
