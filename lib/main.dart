import 'package:business_travel_tracker/new_record.dart';
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
    final record = Record(name: name, amount: amount, date: date);
    setState(() {
      records.add(record);
    });
  }

  void insertNewRecord(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return GestureDetector(
          child: NewRecord(addNewRecord),
        );
      },
    );
  }

  double amountSum() {
    if (records.isEmpty) {
      return 0;
    }
    return records
        .map((record) => record.amount)
        .reduce((value, element) => value + element);
  }

  final List<Record> records = [
    // Record(
    //   amount: 25.99,
    //   date: DateTime(2022, 9, 7),
    //   name: 'Taxi to the Airport',
    // ),
    // Record(
    //   amount: 89.99,
    //   date: DateTime(2022, 9, 5),
    //   name: 'Airplane ticket',
    // ),
    // Record(
    //   amount: 30.89,
    //   date: DateTime(2022, 9, 6),
    //   name: 'Dinner at the Airport',
    // ),
    // Record(
    //   amount: 31.23,
    //   date: DateTime(2022, 9, 7),
    //   name: 'Taxi to Hotel',
    // ),
    // Record(
    //   amount: 12.09,
    //   date: DateTime(2022, 9, 6),
    //   name: 'Coffe',
    // ),
    // Record(
    //   amount: 2.89,
    //   date: DateTime(2022, 9, 6),
    //   name: 'Metro Ticket',
    // ),
    // Record(
    //   amount: 3.5,
    //   date: DateTime(2022, 9, 6),
    //   name: 'Sandwich',
    // ),
    // Record(
    //   amount: 15.89,
    //   date: DateTime(2022, 9, 9),
    //   name: 'Taxi to hotel',
    // ),
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
          Chart(amountSum()),
          SizedBox(
            height: 10,
          ),
          records.isEmpty
              ? Column(
                  children: [Text('Empty list')],
                )
              : SingleChildScrollView(child: ListofRecords(records)),
          SizedBox(
            width: 75,
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            tooltip: 'Add new record',
            onPressed: () => insertNewRecord(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
