import 'dart:io';

import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/record.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Box travelBox = Hive.box<Record>('travel');
  final maxAmountController = TextEditingController();

  Future<void> saveMaxAmount() async {
    if (maxAmountController.text.isEmpty) {
      return;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(
          'maxAmount', double.parse(maxAmountController.text));
      print(prefs);
    }
  }

  void pushMain(BuildContext context) {
    if (maxAmountController.text.isEmpty) {
      return;
    } else {
      Navigator.of(context).pushNamed('/main_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: const MyAppBarMaterial(),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Center(
                      child: Text(
                        'Let\'s start your next trip!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Please enter below your budget.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Center(
                          child: Text('Insert total budget for this Travel'),
                        ),
                      ),
                      controller: maxAmountController,
                      onChanged: (_) => saveMaxAmount(),
                    ),
                    ElevatedButton(
                        onPressed: () => pushMain(context),
                        child: const Text('Go to tracker!')),
                  ],
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Business Travel Tracker'),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Center(
                      child: Text(
                        'Let\'s start your next trip!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Please enter below your budget.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    CupertinoTextField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      placeholder: 'Insert your budget',
                      controller: maxAmountController,
                      onChanged: (_) => saveMaxAmount(),
                    ),
                    CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(15),
                        onPressed: () => pushMain(context),
                        child: const Text(
                          'Go to tracker!',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ));
  }
}
