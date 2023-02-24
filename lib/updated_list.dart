import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list.dart';
import 'models/record.dart';

class UpdatedList extends StatefulWidget {
  final List<Record> records;

  final Function deleteTransaction;

  UpdatedList(this.deleteTransaction, this.records, {super.key});

  @override
  State<UpdatedList> createState() => _UpdatedListState();
}

class _UpdatedListState extends State<UpdatedList> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Platform.isAndroid
        ? Container(
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: SingleChildScrollView(
                child: ListofRecords(widget.records, widget.deleteTransaction)),
          )
        : Container(
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: SingleChildScrollView(
                child: ListofRecords(widget.records, widget.deleteTransaction)),
          );
  }
}
