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
    final routes = {
      '/': (context) => WelcomePage(maxAmount),
      '/main_page': (context) => MainPage(
          title: 'Business Travel Tracker',
          addNewRecord: addNewRecord,
          insertNewRecord: insertNewRecord,
          deleteTransaction: deleteTransaction,
          amountSum: amountSum,
          maxAmount: maxAmount,
          maxAmountcontroller: maxAmountcontroller,
          saveMaxamount: saveMaxamount)
    };
    final routesArguments = ModalRoute.of(context)?.settings.arguments,
        isIOS = Platform.isIOS;
    return isIOS
        ? CupertinoApp(
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
            ],
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

            // home: MyHomePage(title: 'Business Travel Tracker'),
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
            // home: MyHomePage(title: 'Business Travel Tracker'),
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
          );
  }
}

//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({
//     super.key,
//     required this.title,
//   });
//
//   final String title;
//
//   final List<Record> records = [];
//
//   @override
//   State<MyHomePage> createState() => MyHomePageState();
// }
//
// class MyHomePageState extends State<MyHomePage> {
//   void addNewRecord(
//     String name,
//     double amount,
//     DateTime date,
//   ) {
//     final record = Record(
//       name: name,
//       amount: amount,
//       date: date,
//       id: DateTime.now().toString(),
//     );
//     setState(() {
//       records.add(record);
//     });
//   }
//
//   void insertNewRecord(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext) {
//         return GestureDetector(
//           onTap: () {},
//           behavior: HitTestBehavior.opaque,
//           child: NewRecord(addNewRecord),
//         );
//       },
//     );
//   }
//
//   void deleteTransaction(String id) {
//     setState(() {
//       records.removeWhere((text) {
//         return text.id == id;
//       });
//     });
//   }
//
//   double amountSum() {
//     if (records.isEmpty) {
//       return 0;
//     }
//     return records
//         .map((record) => record.amount)
//         .reduce((value, element) => value + element);
//   }
//
//   final List<Record> records = [];
//
//   void showLogin(BuildContext context) {
//     showMenu(
//         context: context,
//         position: RelativeRect.fromLTRB(0, 0, 0, 0),
//         items: [
//           PopupMenuItem<int>(
//             value: 0,
//             child: Text('Log in'),
//           ),
//         ]);
//   }
//
//   double maxAmount = 0;
//   final maxAmountcontroller = TextEditingController();
//
//   void saveMaxamount() {
//     if (maxAmountcontroller.text.isEmpty) {
//       return;
//     } else {
//       setState(() {
//         maxAmount = double.parse(maxAmountcontroller.text);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//
//     return maxAmount != 0
//         ? Platform.isAndroid
//             ? Scaffold(
//                 drawer: const MyDrawer(),
//                 appBar: MyAppBar(
//                   insertNewRecord,
//                 ),
//                 body: SafeArea(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               height: (mediaQuery.size.height -
//                                       60 -
//                                       mediaQuery.padding.top) *
//                                   0.4,
//                               child: Expanded(
//                                   child: Chart(amountSum(), maxAmount))),
//                           records.isEmpty
//                               ? EmptyPage(insertNewRecord)
//                               : UpdatedList(deleteTransaction, records),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 floatingActionButtonLocation:
//                     FloatingActionButtonLocation.centerFloat,
//                 floatingActionButton: FloatingActionButton(
//                   tooltip: 'Add new record',
//                   onPressed: () => insertNewRecord(context),
//                   child: const Icon(Icons.add),
//                 ),
//               )
//             : CupertinoTabScaffold(
//                 tabBar: CupertinoTabBar(
//                   items: const [
//                     BottomNavigationBarItem(
//                       label: 'Login to your profile',
//                       icon: Icon(Icons.login),
//                     ),
//                     BottomNavigationBarItem(
//                       label: 'Update details of travel',
//                       icon: Icon(Icons.change_circle),
//                     ),
//                   ],
//                 ),
//                 tabBuilder: (BuildContext context, int index) {
//                   return CupertinoTabView(
//                     builder: (BuildContext context) {
//                       return CupertinoPageScaffold(
//                         navigationBar: MyAppBar(
//                           insertNewRecord,
//                         ) as ObstructingPreferredSizeWidget,
//                         child: SafeArea(
//                           child: SingleChildScrollView(
//                             child: Container(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     height: (mediaQuery.size.height -
//                                             60 -
//                                             mediaQuery.padding.top) *
//                                         0.4,
//                                     child: Expanded(
//                                       child: Chart(amountSum(), maxAmount),
//                                     ),
//                                   ),
//                                   records.isEmpty
//                                       ? EmptyPage(insertNewRecord)
//                                       : UpdatedList(deleteTransaction, records),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               )
//         : WelcomePage(
//             insertNewRecord,
//             saveMaxamount,
//             showLogin,
//             maxAmountcontroller,
//           );
//   }
// }
