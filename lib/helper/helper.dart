import 'dart:async';
import 'package:family_tree_app/ui/adddatataform.dart';
import 'package:family_tree_app/ui/addparents.dart';
import 'package:family_tree_app/ui/myprofile.dart';
import 'package:family_tree_app/utils/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
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

  static text(
      String text, size, Color? color, FontWeight? fontWeight, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: double.parse(
              size.toString(),
            ),
          )),
    );
  }

  static myprofilecard(
      BuildContext context,
      String? image,
      String? userid,
      String name,
      String? sex,
      bool? single,
      bool? amI,
      bool? root,
      String? headtext,
      bool? parentspresent,
      String? familyname,
      bool? showring) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width / 3,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5)),
              ]),
          child: const Column(
            children: [],
          ),
        ),
        Positioned(
          top: 34,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              color: amI == true
                  ? const Color(0xff005D9A)
                  : headtext == "You"
                      ? const Color(0xff0094FF)
                      : const Color(0xff42b0ff),
              height: 85,
              width: MediaQuery.of(context).size.width / 3,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: MediaQuery.of(context).size.width / 14,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(image.toString()),
                    radius: 35,
                    backgroundColor: Colors.grey,
                    // child: Image.asset(
                    //   "assets/images/rose.png",
                    //   height: 35,
                    // ),
                  ),
                  // Positioned(
                  //     top: 36,
                  //     left: 25,
                  //     child: Image.asset(
                  //       "assets/images/rose.png",
                  //       height: 35,
                  //     )),
                  amI != true
                      ? const SizedBox.shrink()
                      : Positioned(
                          top: 48,
                          left: 50,
                          child: InkWell(
                            child: Image.asset("assets/images/pluscircle.png"),
                            onTap: () {
                              Helper.showAdd(
                                  context,
                                  userid,
                                  single == true ? true : false,
                                  single == false ? true : false,
                                  true);
                            },
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 23,
                  ),
                  Text(
                    headtext.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 8),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  single == true
                      ? const SizedBox.shrink()
                      : showring == false
                          ? const SizedBox.shrink()
                          : Image.asset(
                              "assets/images/couplering.png",
                              height: 12,
                            ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    Image.asset(
                      "assets/images/leftarrow.png",
                      height: 16,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfile(
                                familyname: familyname,
                                name: name,
                                image: image.toString(),
                                userId: userid.toString(),
                              )));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  static hDivider({required width}) {
    return SizedBox(
        width: width,
        child: const Stack(
          children: [
            Divider(
              color: Colors.black,
              thickness: 5.0,
            ),
            Positioned(
              left: 13,
              child: CircleAvatar(
                radius: 8,
                backgroundImage: AssetImage('assets/wedding-rings.png'),
              ),
            )
          ],
        ));
  }

  static vDivider({required height}) {
    return SizedBox(
        height: height,
        child: const Stack(
          children: [
            VerticalDivider(
              thickness: 5.0,
              color: Colors.black,
            ),
            // const Positioned(
            //   top: 33,
            //   left: 0,
            //   child: CircleAvatar(
            //     radius: 8,
            //     backgroundImage: AssetImage('assets/children.png'),
            //   ),
            // )
          ],
        ));
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

  static loadingindicator(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Lottie.asset('assets/lotties/loading.json'),
    );
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

  static textformfiled(hinttext, TextEditingController textcontroller,
      String keyboardtype, bool validation) {
    return TextFormField(
      inputFormatters: [
        keyboardtype == "text"
            ? LengthLimitingTextInputFormatter(1000)
            : LengthLimitingTextInputFormatter(10),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          if (validation == false) {
            return null;
          } else {
            return "this field is required";
          }
        }
        return null;
      },
      showCursor: true,
      cursorColor: Colors.black,
      autocorrect: true,
      controller: textcontroller,
      textInputAction: TextInputAction.done,
      keyboardType:
          keyboardtype == "text" ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[50],
        labelText: hinttext,
        // labelStyle: AppStyles.buttonloginText,
      ),
    );
  }

  static showAdd(
      BuildContext context, uid, spousepresent, childpresent, parentspresent) {
    return showDialog(
      barrierDismissible: true,
      barrierColor: Colors.white70,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          // title: const Text(
          //     "Do you want to delete the site  "),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 235,
              width: 269,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0, top: 10),
                      child: Text(
                        "Choose Who to Add",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  "assets/images/addspouse.png",
                                  height: 80,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  spousepresent == true
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddDataForm(
                                                  pagenavname: "Spouse",
                                                  uid: uid.toString())))
                                      : "";
                                },
                              ),
                              // Helper.generatecontainer(35, 60, "Spouse",

                              //     spousepresent, uid, context),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                    "assets/images/addparents.png",
                                    height: 80),
                                onTap: () {
                                  Navigator.pop(context);
                                  parentspresent == true
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddParentsForm(
                                                      pagenavname: "Parents",
                                                      uid: uid.toString())))
                                      : "";
                                },
                              ),

                              //  Helper.generatecontainer(
                              // 35, 60, "Parents", parentspresent, uid, context),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                    "assets/images/addchildrens.png",
                                    height: 80),
                                onTap: () {
                                  Navigator.pop(context);
                                  childpresent == true
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddDataForm(
                                                  pagenavname: "Child",
                                                  uid: uid.toString())))
                                      : "";
                                },
                              ),
                              //  Helper.generatecontainer(
                              //         35, 60, "Children", childpresent, uid, context),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset("assets/images/addphotos.png",
                                  height: 80),
                              //     Helper.generatecontainer(
                              // 35, 60, "Photos", true, uid, context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget generatecontainer(double height, double width, String? name,
      bool? enable, String? uid, BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: enable == false ? Colors.grey : Colors.blue,
        ),
        height: height,
        // width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name.toString(),
              style: const TextStyle(color: Colors.white)),
        ),
      ),
      onTap: () async {
        Navigator.pop(context);
        enable == true
            ? name == "Parents"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddParentsForm(
                            pagenavname: name.toString(), uid: uid.toString())))
                : name == "Photos"
                    ? ""
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDataForm(
                                pagenavname: name.toString(),
                                uid: uid.toString())))
            : "";
        // await Future.delayed(const Duration(seconds: 1));
      },
    );
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
