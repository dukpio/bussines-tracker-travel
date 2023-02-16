import 'dart:io';

import 'package:business_travel_tracker/new_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart.dart';
import 'list.dart';
import 'models/record.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            leading: IconButton(
                onPressed: () => showLogin(context),
                icon: Icon(CupertinoIcons.person_alt_circle_fill)),
            middle: Text(widget.title),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => insertNewRecord(context),
              )
            ]),
          )
        : AppBar(
            leading: IconButton(
                onPressed: () => showLogin(context),
                icon: Icon(Icons.account_circle_sharp)),
            title: Text(widget.title),
          ) as PreferredSizeWidget;

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.4,
                          child: Expanded(child: Chart(amountSum()))),
                      records.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.6,
                              child: Platform.isAndroid
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            'Please insert your first record\nTo do this, please use the button below.'),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CupertinoButton.filled(
                                          alignment: Alignment.center,
                                          onPressed: () =>
                                              insertNewRecord(context),
                                          child: const Text(
                                              'Please insert your first record'),
                                        ),
                                      ],
                                    ),
                            )
                          : Container(
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.6,
                              child: SingleChildScrollView(
                                  child: ListofRecords(
                                      records, deleteTransaction)),
                            ),
                      // SizedBox(
                      //   width: 75,
                      // ),
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
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.4,
                          child: Expanded(child: Chart(amountSum()))),
                      records.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Please insert your first record\nTo do this, please use the button below.'),
                                ],
                              ))
                          : Container(
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.6,
                              child: SingleChildScrollView(
                                  child: ListofRecords(
                                      records, deleteTransaction)),
                            ),
                      // SizedBox(
                      //   width: 75,
                      // ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
