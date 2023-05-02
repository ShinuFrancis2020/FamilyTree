import 'dart:async';
import 'package:family_tree_app/utils/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Helper {
  // DONOT DELETE 👇
  // border: Border.all(color: Colors.red),
  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static shrink() {
    return const SizedBox.shrink();
  }

  static loading(BuildContext context) {
    return showDialog(
        barrierColor: Colors.white70,
        barrierDismissible: false,
        context: context,
        builder: (context) => const ShowDialog());
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static allowHeight(double height) {
    return SizedBox(height: height);
  }

  static allowWidth(double width) {
    return SizedBox(width: width);
  }

  void coreSnackbar(GlobalKey<ScaffoldState>? scaffoldKey, String? content,
      {IconData? icon, Color? color}) {
    var snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon!,
            color: color!,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              content!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(snackBar);
  }

  static RegExp exp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  static RegExp phoexp = RegExp(r"^[0-9]{10}$");
  static String formatEmail(String newText) {
    // Regular expression to check for valid email
    RegExp exp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (exp.hasMatch(newText)) {
      return newText;
    }
    return "";
  }

  static showToast({required msg}) {
    Fluttertoast.cancel(); // for immediate stopping
    return Fluttertoast.showToast(msg: msg);
  }

  static locaStorageInst() async {
    return SharedPreferences.getInstance();
  }

  static push(BuildContext context, dynamic route) {
    return Navigator.push(
        context, MaterialPageRoute(builder: ((context) => route)));
  }

  static pushReplacement(BuildContext context, dynamic route) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => route)));
  }

  static pushReplacementRemove(BuildContext context, String namedRoute) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(namedRoute, (Route<dynamic> route) => false);
  }

  static emailRegexp() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }

  static pushReplacementWithDelay(BuildContext context, dynamic route,
      [delay]) {
    return Future.delayed(Duration(seconds: delay ?? 3), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => route)));
    });
  }

  // static void checkUpdate(BuildContext context) {
  //   InAppUpdate.checkForUpdate().then((value) {
  //     value.updateAvailability != UpdateAvailability.updateAvailable
  //         ? showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: const Text("App update available"),
  //                 content: const Text("A new versions of the app is available"),
  //                 actions: [
  //                   TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: const Text("Later")),
  //                   TextButton(
  //                       onPressed: () {
  //                         launchPlay(context);
  //                       },
  //                       child: const Text("Update Now"))
  //                 ],
  //               );
  //             })
  //         : {};
  //   });
  // }

  // static Future<void> launchPlay(BuildContext context) async {
  //   Navigator.pop(context);
  //   var url = Uri.parse(
  //       'https://play.google.com/store/apps/details?id=com.leopard.ole_rd');

  //   await canLaunchUrl(url)
  //       ? await launchUrl(url, mode: LaunchMode.externalApplication)
  //       : throw ('Could not launch https://play.google.com/store/apps/details?id=com.leopard.ole_rd');
  // }

  // static getVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   Initializer.version = '${packageInfo.version}+${packageInfo.buildNumber}';
  // }
}
