import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void pushWelcome(BuildContext context) {
      Navigator.of(context).pushNamed('/');
    }

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Text("Business Tracker Travel")),
          const ListTile(
            leading: Icon(Icons.login),
            title: Text('Login to your profile'),
            onTap: null,
          ),
          ListTile(
            leading: const Icon(Icons.change_circle),
            title: const Text('Update the budget'),
            onTap: () => pushWelcome(context),
          )
        ],
      ),
    );
  }
}
