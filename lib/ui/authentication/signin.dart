import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/ui/authentication/signup.dart';
import 'package:family_tree_app/ui/familyhomescreen.dart';
import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool show = false;
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is LoginSucces) {
            Helper.pushReplacement(context, const FamilyHome());
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: Initializer.loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 350,
                    child: Image.asset('assets/images/Family.png'),
                  ),

                  SizedBox(
                    height: Helper.height(context) / 50,
                  ),
                  Helper.text("Connect Generations with KinshipTree", 20,
                      Colors.black, FontWeight.bold, 8),

                  ///5height
                  SizedBox(
                    height: Helper.height(context) / 100,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Helper.text(
                        "Email", 16, Colors.black, FontWeight.w500, 8),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: 58,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                        showCursor: true,
                        cursorColor: Colors.black,
                        autocorrect: true,
                        controller: username,
                        // obscureText: !show,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          suffixIcon: Image.asset(
                            'assets/images/Message.png',
                            width: 20,
                            height: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xfff4d74be),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.grey[50],
                          labelText: "",
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Helper.height(context) / 180,
                  // ),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Helper.text(
                        "Password", 16, Colors.black, FontWeight.w500, 8),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: 48,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                        showCursor: true,
                        cursorColor: Colors.black,
                        autocorrect: true,
                        controller: password,
                        obscureText: !show,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xfff4d74be),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.grey[50],
                          labelText: "",
                          // labelStyle: AppStyles.buttonloginText,
                        ),
                      ),
                    ),
                  ),
                  Helper.allowHeight(10),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SizedBox(
                      //width: Helper.width(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                            height: 48,
                            minWidth: MediaQuery.of(context).size.width / 1,
                            color: const Color(0xff2B8DD4),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              if (Initializer.loginKey.currentState!
                                  .validate()) {
                                context.read<MainBloc>().add(DoLogin(
                                    username: username.text,
                                    password: password.text));
                              }
                            }),
                      ),
                    ),
                  ),
                  Helper.allowHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Helper.text("Don't Have  an Account..?", 12,
                                  Colors.black, FontWeight.w100, 0),
                              InkWell(
                                child: Helper.text("Sign Up", 12, Colors.blue,
                                    FontWeight.bold, 0),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      "By clicking Register You Agree to our \nTerms of services and Privacy Policy",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8C8888)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
