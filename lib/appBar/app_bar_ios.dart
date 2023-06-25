import 'package:flutter/cupertino.dart';

class MyAppBarIos extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Function insertNewRecord;

  const MyAppBarIos(this.insertNewRecord, {super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;

    return CupertinoNavigationBar(
      middle: const Text('Business Travel Tracker'),
      trailing: CupertinoButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: () => insertNewRecord(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    return false;
  }
}
