import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRecordIos extends StatefulWidget {
  final Function addText;
  NewRecordIos(this.addText);

  @override
  State<NewRecordIos> createState() => _NewRecordIosState();
}

class _NewRecordIosState extends State<NewRecordIos> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  late String selectedDateString = '';
  late DateTime selectedDate;

  void presentDate() {
    showCupertinoModalPopup(
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
    return CupertinoAlertDialog(
      title: const Text('New Record'),
      content: Card(
        elevation: 0.0,
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
              CupertinoButton(
                  onPressed: presentDate,
                  child: Text(elevatedDateSelectionButton())),
            ]),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            _saveData();
          },
          child: const Text('Submit'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
