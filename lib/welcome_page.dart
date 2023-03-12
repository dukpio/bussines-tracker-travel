import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

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

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: MyAppBar(widget.insertNewRecord,)
                as PreferredSizeWidget,
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
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: MyAppBar(widget.insertNewRecord,)
                as ObstructingPreferredSizeWidget,
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
                    ],
                  ),
                ),
              ),
            ));
  }
}
