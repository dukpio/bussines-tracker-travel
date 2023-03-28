import 'dart:io';

import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage(double maxAmount, {super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double maxAmount = 0;
  final maxAmountController = TextEditingController();

  void saveMaxAmount() {
    if (maxAmountController.text.isEmpty) {
      return;
    } else {
      setState(() {
        maxAmount = double.parse(maxAmountController.text);
      });
    }
  }

  void pushMain(BuildContext context) {
    if (maxAmountController.text.isEmpty) {
      return;
    } else {
      Navigator.of(context)
          .pushNamed('/main_page', arguments: {'maxAmount': maxAmount});
    }
    ;
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
                      onSubmitted: (_) => saveMaxAmount(),
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
              child: SingleChildScrollView(
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
                        onSubmitted: (_) => saveMaxAmount(),
                      ),
                      CupertinoButton(
                          onPressed: () => pushMain(context),
                          child: const Text('Go to tracker!')),
                    ],
                  ),
                ),
              ),
            ));
  }
}
