import 'package:flutter/material.dart';
import 'chart.dart';
import 'list.dart';
import './record.dart';

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
          fontFamily: 'Dolgan',
          appBarTheme: AppBarTheme(centerTitle: true)),
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

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Record> records = [
    Record(
      amount: 25.99,
      date: DateTime(2022, 9, 7),
      nameofTransaction: 'Taxi to the Airport',
    ),
    Record(
      amount: 89.99,
      date: DateTime(2022, 9, 5),
      nameofTransaction: 'Airplane ticket',
    ),
    Record(
      amount: 30.89,
      date: DateTime(2022, 9, 6),
      nameofTransaction: 'Dinner at the Airport',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 75,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Project name'),
                  controller: null,
                  onSubmitted: null,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Project budget'),
                  controller: null,
                  onSubmitted: null,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Chart(),
          SizedBox(
            height: 10,
          ),
          ListofRecords(records),
          SizedBox(
            width: 75,
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: null,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
