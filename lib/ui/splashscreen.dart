import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/ui/authentication/signin.dart';
import 'package:family_tree_app/ui/homescreen.dart';
import 'package:family_tree_app/ui/roughshreach.dart';
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
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/family.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> getToken() async {
    // Helper.pushReplacement(context, const Authentication());
    var token = await LocalStorage.getToken();
    debugPrint(token);
    if (token != null) {
      debugPrint("token $token ${DateTime.now()}");
      await Future.delayed( Duration(seconds: 2));
      Helper.pushReplacement(context, const RoughPage());
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Helper.pushReplacement(context, const Authentication());
    }
  }
}
