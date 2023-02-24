import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function insertNewRecord;
  final Function showLogin;

  const MyAppBar(this.insertNewRecord, this.showLogin, {super.key});

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
            leading: CupertinoButton(
              child: const Icon(CupertinoIcons.person_alt_circle_fill),
              onPressed: () => showLogin(context),
            ),
          )
        : AppBar(
            leading: IconButton(
                onPressed: () => showLogin(context),
                icon: const Icon(Icons.account_circle_sharp)),
            title: const Text('Business Travel Tracker'),
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
