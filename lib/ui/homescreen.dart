import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/ui/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Family"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Helper.push(context, const Profile());
                // Update the UI
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
