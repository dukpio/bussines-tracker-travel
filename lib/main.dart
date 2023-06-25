import 'dart:io';

import 'package:business_travel_tracker/new_rec/new_record_ios.dart';
import 'package:business_travel_tracker/screens/main_page.dart';
import 'package:business_travel_tracker/screens/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/record.dart';
import 'new_rec/new_record_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox<Record>('travel');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Box travelBox = Hive.box<Record>('travel');

  @override
  void initState() {
    super.initState();
    travelBox = Hive.box<Record>('travel');
  }

  double maxAmount = 0;

  void refreshRecords() {
    final data = travelBox.keys.map((key) {
      final value = travelBox.get(key);
      return {
        'key': key,
        'name': value['name'],
        'amount': value['amount'],
        'date': value['date'],
        'id': value['id']
      };
    }).toList();

    setState(() {});
  }

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
      travelBox.add(record);
      travelBox.values.forEach((element) {
        print(element.id);
        print(element.date);
        print(element.amount);
      });
      print(travelBox.values);
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

  void insertNewRecordIOs(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewRecordIos(addNewRecord),
        );
      },
    );
  }

  double amountSum() {
    if (travelBox.isEmpty) {
      return 0;
    }
    return travelBox.values
        .map((record) => record.amount)
        .reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => WelcomePage(maxAmount),
      '/main_page': (context) => MainPage(
            amountSum: amountSum,
            insertNewRecord: insertNewRecord,
            insertNewRecordIOs: insertNewRecordIOs,
            title: 'Business Travel Tracker',
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
              appBarTheme: const AppBarTheme(centerTitle: true),
              fontFamily: 'Garute',
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                      .copyWith(
                          background: const Color.fromARGB(255, 195, 231, 228)),
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
