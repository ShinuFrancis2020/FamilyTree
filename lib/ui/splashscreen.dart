import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/ui/authentication/signin.dart';
import 'package:family_tree_app/ui/familyhomescreen.dart';
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
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.2,
        child: Image.asset(
          'assets/images/splashimg.png',
          fit: BoxFit.contain,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Image.asset(
            'assets/familyfinallogo.png',
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
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Helper.pushReplacement(context, const FamilyHome());
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Helper.pushReplacement(context, const Authentication());
      }
    }
  }
}
