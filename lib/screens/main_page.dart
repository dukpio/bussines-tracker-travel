import 'dart:io';

import 'package:business_travel_tracker/Chart/empty_list.dart';
import 'package:business_travel_tracker/Chart/updated_list.dart';
import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Chart/chart.dart';
import '../drawer.dart';
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

  late double maxAmount;

  final TextEditingController maxAmountcontroller;

  final Function saveMaxamount;

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

    final List<Record> records = [];

    return Platform.isAndroid
        ? Scaffold(
            drawer: MyDrawer(),
            appBar: MyAppBarMaterial(),
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
                              child: Chart(widget.amountSum(), maxAmount!))),
                      records.isEmpty
                          ? EmptyPage(widget.insertNewRecord)
                          : UpdatedList(widget.deleteTransaction, records),
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
              items: const [
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
                    navigationBar: CupertinoNavigationBar(
                        middle: const Text('Business Travel Tracker'),
                        trailing: CupertinoButton(
                          child: const Icon(CupertinoIcons.add),
                          onPressed: null,
                        )),
                    child: SafeArea(
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
                                  child: Chart(widget.amountSum(), maxAmount!),
                                ),
                              ),
                              widget.records.isEmpty
                                  ? EmptyPage(widget.insertNewRecord)
                                  : UpdatedList(
                                      widget.deleteTransaction, widget.records),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
    // : WelcomePage(
    //     widget.insertNewRecord,
    //     widget.saveMaxamount,
    //     widget.showLogin,
    //     widget.maxAmountcontroller,
    //   );
  }
}
