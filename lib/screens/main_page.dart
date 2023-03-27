import 'dart:io';

import 'package:business_travel_tracker/Chart/empty_list.dart';
import 'package:business_travel_tracker/Chart/updated_list.dart';
import 'package:business_travel_tracker/app_bar.dart';
import 'package:business_travel_tracker/drawer.dart';
import 'package:business_travel_tracker/screens/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Chart/chart.dart';
import '../models/record.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';
  MainPage({
    Key? key,
    required this.title,
    required this.addNewRecord,
    required this.insertNewRecord,
    required this.deleteTransaction,
    required this.amountSum,
    required this.showLogin,
    required this.maxAmount,
    required this.maxAmountcontroller,
    required this.saveMaxamount,
  }) : super(key: key);

  final String title;

  final List<Record> records = [];

  final Function addNewRecord;

  final Function insertNewRecord;

  final Function deleteTransaction;

  final Function amountSum;

  final Function showLogin;

  late double maxAmount;

  final TextEditingController maxAmountcontroller;

  final Function saveMaxamount;

  @override
  State<MainPage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return widget.maxAmount != 0
        ? Platform.isAndroid
            ? Scaffold(
                drawer: MyDrawer(),
                appBar: MyAppBar(
                  widget.insertNewRecord,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: (mediaQuery.size.height -
                                      60 -
                                      mediaQuery.padding.top) *
                                  0.4,
                              child: Expanded(
                                  child: Chart(
                                      widget.amountSum(), widget.maxAmount))),
                          widget.records.isEmpty
                              ? EmptyPage(widget.insertNewRecord)
                              : UpdatedList(
                                  widget.deleteTransaction, widget.records),
                        ],
                      ),
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
            : CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: [
                    BottomNavigationBarItem(
                      label: 'Login to your profile',
                      icon: Icon(Icons.login),
                    ),
                    BottomNavigationBarItem(
                      label: 'Update details of travel',
                      icon: Icon(Icons.change_circle),
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        navigationBar: MyAppBar(
                          widget.insertNewRecord,
                        ) as ObstructingPreferredSizeWidget,
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: (mediaQuery.size.height -
                                            60 -
                                            mediaQuery.padding.top) *
                                        0.4,
                                    child: Expanded(
                                      child: Chart(
                                          widget.amountSum(), widget.maxAmount),
                                    ),
                                  ),
                                  widget.records.isEmpty
                                      ? EmptyPage(widget.insertNewRecord)
                                      : UpdatedList(widget.deleteTransaction,
                                          widget.records),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
        : WelcomePage(
            widget.insertNewRecord,
            widget.saveMaxamount,
            widget.showLogin,
            widget.maxAmountcontroller,
          );
  }
}
