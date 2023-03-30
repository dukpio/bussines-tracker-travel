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

  final Function deleteTransaction;

  List<Record> records;

  final String title;

  MainPage({
    Key? key,
    required this.title,
    required this.amountSum,
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
    void pushWelcome(BuildContext context) {
      Navigator.of(context).pushNamed('/');
    }

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
                          child: Chart(widget.amountSum(), maxAmount!)),
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
              onTap: null, //DO UZUPELNIANIA!
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    navigationBar: MyAppBarIos(widget.insertNewRecord),
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
                                child: Chart(widget.amountSum(), maxAmount!),
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
  }
}
