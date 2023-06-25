import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../list.dart';
import '../models/record.dart';

class UpdatedList extends StatefulWidget {
  Box travelBox = Hive.box<Record>('travel');

  UpdatedList({super.key});

  @override
  State<UpdatedList> createState() => _UpdatedListState();
}

class _UpdatedListState extends State<UpdatedList> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Platform.isAndroid
        ? SizedBox(
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: SingleChildScrollView(child: ListofRecords()),
          )
        : SizedBox(
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: SingleChildScrollView(child: ListofRecords()),
          );
  }
}
