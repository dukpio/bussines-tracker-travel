import 'dart:io';

import 'package:business_travel_tracker/Chart/empty_list.dart';
import 'package:business_travel_tracker/Chart/updated_list.dart';
import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Chart/chart.dart';
import '../appBar/app_bar_ios.dart';
import '../drawer.dart';
import '../models/record.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  final Function amountSum;

  final Function insertNewRecord;

  final Function insertNewRecordIOs;

  final Function deleteTransaction;

  List<Record> records;

  final String title;

  MainPage({
    Key? key,
    required this.title,
    required this.amountSum,
    required this.insertNewRecordIOs,
    required this.insertNewRecord,
    required this.deleteTransaction,
    required this.records,
  }) : super(key: key);

  @override
  State<MainPage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, double>;

    double? maxAmount = args['maxAmount'];

    final mediaQuery = MediaQuery.of(context);

    return Platform.isAndroid
        ? Scaffold(
            drawer: const MyDrawer(),
            appBar: const MyAppBarMaterial(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: (mediaQuery.size.height -
                                60 -
                                mediaQuery.padding.top) *
                            0.4,
                        child: Chart(widget.amountSum(), maxAmount!)),
                    widget.records.isEmpty
                        ? EmptyPage(widget.insertNewRecord)
                        : UpdatedList(widget.deleteTransaction, widget.records),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add new record',
              onPressed: () => widget.insertNewRecord(context),
              child: const Icon(Icons.add),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: MyAppBarIos(widget.insertNewRecordIOs),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: (mediaQuery.size.height -
                              60 -
                              mediaQuery.padding.top) *
                          0.4,
                      child: Chart(widget.amountSum(), maxAmount!),
                    ),
                    widget.records.isEmpty
                        ? EmptyPage(widget.insertNewRecordIOs)
                        : UpdatedList(widget.deleteTransaction, widget.records),
                  ],
                ),
              ),
            ),
          );
  }
}
