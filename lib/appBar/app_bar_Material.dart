import 'package:flutter/material.dart';

class MyAppBarMaterial extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    return AppBar(
      title: const Text('Business Travel Tracker'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
