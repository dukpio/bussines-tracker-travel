import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: const [
        DrawerHeader(child:
          Text("Business Tracker Travel")
          ),
        ListTile(
          leading: Icon(Icons.login),
          title: Text('Login to your profile'),
          onTap: null,
        )
        ],
      ),
    );
  }
}

