import 'package:family_tree_app/ui/navdrawer.dart';
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
      drawer: const HomeDrawer(),
      body: Column(
        children: const [],
      ),
    );
  }
}
