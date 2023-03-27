import 'dart:io';

import 'package:business_travel_tracker/appBar/app_bar_Material.dart';
import 'package:business_travel_tracker/appBar/app_bar_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final Function insertNewRecord;

  final Function showLogin;

  final Function saveMaxamount;

  TextEditingController maxAmountcontroller;

  WelcomePage(this.insertNewRecord, this.saveMaxamount, this.showLogin,
      this.maxAmountcontroller,
      {super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

void selectCategory(BuildContext context) {
  Navigator.of(context).pushNamed('/main_page'); //ale moze tez byc nazwa route
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: MyAppBarMaterial(),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: const Text(
                          'Welcome to Business Travel Tracker App! \n Please provide below the travel details \n or \n Please login to your previous trip using icon in the left corner of screen')),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Insert total budget for this Travel'),
                    controller: widget.maxAmountcontroller,
                    onSubmitted: (_) => widget.saveMaxamount(),
                  ),
                  ElevatedButton(
                      onPressed: () => selectCategory(context),
                      child: Text('Go to tracker!')),
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: MyAppBarIos(widget.insertNewRecord),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                          child: const Text(
                              'Welcome to Business Travel Tracker App! \n Please provide below the travel details \n or \n Please login to your previous trip using icon in the left corner of screen')),
                      CupertinoTextField(
                        keyboardType: TextInputType.number,
                        placeholder: 'Insert your budget',
                        controller: widget.maxAmountcontroller,
                        onSubmitted: (_) => widget.saveMaxamount(),
                      ),
                      CupertinoButton(
                          onPressed: () => selectCategory(context),
                          child: Text('Go to tracker!')),
                    ],
                  ),
                ),
              ),
            ));
  }
}
