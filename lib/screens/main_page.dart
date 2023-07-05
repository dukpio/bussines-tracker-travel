import 'dart:io';

import 'package:business_travel_tracker/Chart/empty_list.dart';
import 'package:business_travel_tracker/Chart/updated_list.dart';
import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Chart/chart.dart';
import '../appBar/app_bar_ios.dart';
import '../drawer.dart';
import '../models/record.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  final Function amountSum;

  final Function insertNewRecord;

  final Function insertNewRecordIOs;

  Box travelBox = Hive.box<Record>('travel');

  final String title;

  MainPage({
    Key? key,
    required this.title,
    required this.amountSum,
    required this.insertNewRecordIOs,
    required this.insertNewRecord,
  }) : super(key: key);

  @override
  State<MainPage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MainPage> {
  double maxAmount = 0;

  @override
  void initState() {
    super.initState();
    _loadMaxAmount();
  }

  // Loading counter value on start
  void _loadMaxAmount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      maxAmount = (prefs.getDouble('maxAmount') ?? 0);
    });
  }

  // // Incrementing counter after click
  // void _incrementCounter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0) + 1;
  //     prefs.setInt('counter', _counter);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, double>;
    //
    // double? maxAmount = args['maxAmount'];

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
                    widget.travelBox.isEmpty
                        ? EmptyPage(widget.insertNewRecord)
                        : UpdatedList(),
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
                    widget.travelBox.isEmpty
                        ? EmptyPage(widget.insertNewRecordIOs)
                        : UpdatedList(),
                  ],
                ),
              ),
            ),
          );
  }
}
