import 'dart:io';

import 'package:business_travel_tracker/new_rec/new_record_ios.dart';
import 'package:business_travel_tracker/screens/main_page.dart';
import 'package:business_travel_tracker/screens/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  double maxAmount = 0;
  Box travelBox = Hive.box<Record>('travel');

  @override
  void initState() {
    super.initState();
    travelBox = Hive.box<Record>('travel');
    _loadMaxAmount();
  }

  void _loadMaxAmount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      maxAmount = (prefs.getDouble('maxAmount') ?? 0);
    });
  }

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
      '/': (context) => const WelcomePage(),
      '/main_page': (context) => MainPage(
            amountSum: amountSum,
            insertNewRecord: insertNewRecord,
            insertNewRecordIOs: insertNewRecordIOs,
            title: 'Business Travel Tracker',
          )
    };
    return Platform.isIOS
        ? CupertinoApp(
            initialRoute: maxAmount != 0 ? '/' : '/main_page',
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
            ],
            theme: const CupertinoThemeData(primaryColor: Colors.blueGrey),
            title: 'Business Travel Tracker',
            routes: routes,
            onGenerateRoute: (settings) {
              print(settings.arguments);
              return MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              );
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              );
            },
          )
        : MaterialApp(
            initialRoute: maxAmount != 0 ? '/' : '/main_page',
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
                builder: (context) => const WelcomePage(),
              );
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              );
            },
          );
  }
}
