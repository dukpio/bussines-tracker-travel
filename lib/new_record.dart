import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
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
    showDatePicker(
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
    return Card(
        child: Container(
      child: Column(children: [
        TextField(
          decoration: InputDecoration(labelText: 'Insert name'),
          controller: nameController,
          onSubmitted: (_) => _saveData(),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: amountController,
          decoration: InputDecoration(labelText: 'Insert amount'),
          onSubmitted: (_) => _saveData(),
        ),
        ElevatedButton(
            onPressed: presentDate, child: Text(elevatedDateSelectionButton())),
      ]),
    ));
  }
}
