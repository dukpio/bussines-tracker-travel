import 'dart:io';

import 'package:flutter/cupertino.dart';

class EmptyPage extends StatefulWidget {
  final Function insertNewRecord;

  const EmptyPage(this.insertNewRecord, {super.key});

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Platform.isAndroid
        ? Container(
            width: double.infinity,
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: Platform.isAndroid
                ? const Center(
                    child: Text(
                      'Please insert your first record, by using the button below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton.filled(
                        alignment: Alignment.center,
                        onPressed: () => widget.insertNewRecord(context),
                        child: const Text('Please insert your first record'),
                      ),
                    ],
                  ),
          )
        : Container(
            width: double.infinity,
            height:
                (mediaQuery.size.height - 60 - mediaQuery.padding.top) * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Please insert your first record\nTo do this, please use the button below.'),
              ],
            ));
  }
}
