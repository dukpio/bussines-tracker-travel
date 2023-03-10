import 'dart:io';

import 'package:business_travel_tracker/Chart/empty_list.dart';
import 'package:business_travel_tracker/app_bar.dart';
import 'package:business_travel_tracker/new_record.dart';
import 'package:business_travel_tracker/Chart/updated_list.dart';
import 'package:business_travel_tracker/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chart/chart.dart';
import 'list.dart';
import 'models/record.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    return isIOS
        ? CupertinoApp(
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
            ],
            title: 'Business Travel Tracker',
            home: MyHomePage(title: 'Business Travel Tracker'),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Business Travel Tracker',
            theme: ThemeData(
              backgroundColor: Color.fromARGB(255, 195, 231, 228),
              primarySwatch: Colors.blueGrey,
              appBarTheme: AppBarTheme(centerTitle: true),
              fontFamily: 'Garute',
            ),
            home: MyHomePage(title: 'Business Travel Tracker'),
          );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  final List<Record> records = [];

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void addNewRecord(
    String name,
    double amount,
    DateTime date,
  ) {
    final record = Record(
      name: name,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );
    setState(() {
      records.add(record);
    });
  }

  void insertNewRecord(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewRecord(addNewRecord),
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      records.removeWhere((text) {
        return text.id == id;
      });
    });
  }

  double amountSum() {
    if (records.isEmpty) {
      return 0;
    }
    return records
        .map((record) => record.amount)
        .reduce((value, element) => value + element);
  }

  final List<Record> records = [];

  void showLogin(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: [
          PopupMenuItem<int>(
            value: 0,
            child: Text('Log in'),
          ),
        ]);
  }

  double maxAmount = 0;
  final maxAmountcontroller = TextEditingController();

  void saveMaxamount() {
    if (maxAmountcontroller.text.isEmpty) {
      return;
    } else {
      setState(() {
        maxAmount = double.parse(maxAmountcontroller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return maxAmount != 0
        ? Platform.isAndroid
            ? Scaffold(
                appBar: MyAppBar(insertNewRecord, showLogin),
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
                                  child: Chart(amountSum(), maxAmount))),
                          records.isEmpty
                              ? EmptyPage(insertNewRecord)
                              : UpdatedList(deleteTransaction, records),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  tooltip: 'Add new record',
                  onPressed: () => insertNewRecord(context),
                  child: const Icon(Icons.add),
                ),
              )
            : CupertinoPageScaffold(
                navigationBar: MyAppBar(insertNewRecord, showLogin)
                    as ObstructingPreferredSizeWidget,
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
                                  child: Chart(amountSum(), maxAmount))),
                          records.isEmpty
                              ? EmptyPage(insertNewRecord)
                              : UpdatedList(deleteTransaction, records),
                        ],
                      ),
                    ),
                  ),
                ))
        : WelcomePage(
            insertNewRecord,
            saveMaxamount,
            showLogin,
            maxAmountcontroller,
          );
  }
}
