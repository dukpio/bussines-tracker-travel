import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRecord extends StatefulWidget {
  final Function addText;
  const NewRecord(this.addText);

  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  late String selectedDateString = '';
  late DateTime selectedDate;

  void presentDate() {
    Platform.isAndroid
        ? showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021, 1, 1, 00, 00),
            lastDate: DateTime.now(),
          ).then((markedDate) {
            if (markedDate == null) {
              return;
            }
            setState(() {
              selectedDate = markedDate;
              selectedDateString = DateFormat.MMMMd().format(markedDate);
            });
          })
        : showCupertinoModalPopup(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                color: Colors.white,
                child: Column(
                  children: [
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime markedDate) {
                        setState(() {
                          selectedDate = markedDate;
                          selectedDateString =
                              DateFormat.MMMMd().format(markedDate);
                        });
                      },
                      initialDateTime: DateTime.now(),
                      minimumDate: DateTime(2021, 1, 1, 00, 00),
                      maximumDate: DateTime.now(),
                    ),
                    CupertinoButton(
                      child: const Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            });
  }

  void _saveData() {
    if (nameController.text.isEmpty) {
      return;
    }
    final enteredName = nameController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount <= 0 || enteredName.isEmpty) {
      return;
    }

    widget.addText(enteredName, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  String elevatedDateSelectionButton() {
    if (selectedDateString.isEmpty) {
      return 'Choose date';
    } else {
      return selectedDateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Insert name'),
                controller: nameController,
                onSubmitted: (_) => _saveData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Insert amount'),
                onSubmitted: (_) => _saveData(),
              ),
              ElevatedButton(
                  onPressed: presentDate,
                  child: Text(elevatedDateSelectionButton())),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _saveData();
                    },
                    child: const Text('Submit'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
