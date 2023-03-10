import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_bar.dart';
import 'chart.dart';
import 'empty_list.dart';
import 'updated_list.dart';
import '../models/record.dart';

class ChartSpace extends StatefulWidget {
  final List<Record> records;

  final Function insertNewRecord;

  final Function showLogin;

  final Function amountSum;

  final Function maxAmount;

  final Function deleteTransaction;

  const ChartSpace(this.amountSum, this.insertNewRecord, this.maxAmount,
      this.showLogin, this.deleteTransaction, this.records,
      {super.key});

  @override
  State<ChartSpace> createState() => _ChartSpaceState();
}

class _ChartSpaceState extends State<ChartSpace> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Platform.isAndroid
        ? Scaffold(
            appBar: MyAppBar(widget.insertNewRecord, widget.showLogin),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: (mediaQuery.size.height -
                                  60 -
                                  mediaQuery.padding.top) *
                              0.4,
                          child: Expanded(
                              child: Chart(
                                  widget.amountSum(), widget.maxAmount()))),
                      widget.records.isEmpty
                          ? EmptyPage(widget.insertNewRecord)
                          : UpdatedList(
                              widget.deleteTransaction, widget.records),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: MyAppBar(widget.insertNewRecord, widget.showLogin)
                as ObstructingPreferredSizeWidget,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: (mediaQuery.size.height -
                                  60 -
                                  mediaQuery.padding.top) *
                              0.4,
                          child: Expanded(
                              child: Chart(
                                  widget.amountSum(), widget.maxAmount()))),
                      widget.records.isEmpty
                          ? EmptyPage(widget.insertNewRecord)
                          : UpdatedList(
                              widget.deleteTransaction, widget.records),
                    ],
                  ),
                ),
              ),
            ));
  }
}
