import 'dart:io';

import 'package:business_travel_tracker/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function insertNewRecord;

  const MyAppBar(this.insertNewRecord, {super.key});

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height *0.2;

    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Business Travel Tracker'),
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.add),
              onPressed: () => insertNewRecord(context),
            ),
            // leading: const MyDrawer(),
          )
        : AppBar(
            title: const Text('Business Travel Tracker'),
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}