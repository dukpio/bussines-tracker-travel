import 'dart:io';

import 'package:business_travel_tracker/screens/main_page.dart';
import 'package:business_travel_tracker/screens/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/record.dart';
import 'new_record.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      builder: (BuildContext context) {
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

  double maxAmount = 0;
  // final maxAmountcontroller = TextEditingController();
  //
  // void saveMaxamount() {
  //   if (maxAmountcontroller.text.isEmpty) {
  //     return;
  //   } else {
  //     setState(() {
  //       maxAmount = double.parse(maxAmountcontroller.text);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => WelcomePage(maxAmount),
      '/main_page': (context) => MainPage(
            amountSum: amountSum,
            insertNewRecord: insertNewRecord,
            title: 'Business Travel Tracker',
            deleteTransaction: deleteTransaction,
            records: records,
          )
    };
    return Platform.isIOS
        ? CupertinoApp(
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
            ],
            theme: const CupertinoThemeData(primaryColor: Colors.blueGrey),
            title: 'Business Travel Tracker',
            routes: routes,
            onGenerateRoute: (settings) {
              print(settings.arguments);
              return MaterialPageRoute(
                builder: (context) => WelcomePage(maxAmount),
              );
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => WelcomePage(maxAmount),
              );
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Business Travel Tracker',
            theme: ThemeData(
              backgroundColor: const Color.fromARGB(255, 195, 231, 228),
              primarySwatch: Colors.blueGrey,
              appBarTheme: const AppBarTheme(centerTitle: true),
              fontFamily: 'Garute',
            ),
            routes: routes,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => WelcomePage(maxAmount),
              );
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => WelcomePage(maxAmount),
              );
            },
          );
  }
}
