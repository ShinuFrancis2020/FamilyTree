import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/ui/authentication/signin.dart';
import 'package:family_tree_app/ui/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.co_present,
        size: 46,
      )),
    );
  }

  Future<void> getToken() async {
    // Helper.pushReplacement(context, const Authentication());
    var token = await LocalStorage.getToken();
    debugPrint(token);
    if (token != null) {
      debugPrint("token $token ${DateTime.now()}");
      await Future.delayed(const Duration(seconds: 2));
      Helper.pushReplacement(context, const HomeScreen());
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Helper.pushReplacement(context, const Authentication());
    }
  }
}
