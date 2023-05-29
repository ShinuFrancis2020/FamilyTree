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
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: Initializer.loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 120,
                  //   width: 230,
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage("assets/familyilogo.jpg"),
                  //     radius: 100,
                  //   ),
                  // ),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset('assets/familyilogo.jpg'),
                  ),
                  TextFormField(
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey[50],
                      labelText: "Email",
                    ),
                  ),
                  Helper.allowHeight(20),
                  TextFormField(
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[50],
                      labelText: "Password",
                      // labelStyle: AppStyles.buttonloginText,
                    ),
                  ),
                  Helper.allowHeight(20),
                  SizedBox(
                    //width: Helper.width(context),
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width / 1,
                        color: Colors.green,
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (Initializer.loginKey.currentState!.validate()) {
                            context.read<MainBloc>().add(DoLogin(
                                username: username.text,
                                password: password.text));
                          }
                        }),
                  ),
                  Helper.allowHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Don't Have  an Account..?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                        ),
                      ),
                      // SizedBox(
                      //   //width: Helper.width(context),
                      //   child: MaterialButton(
                      //       minWidth: MediaQuery.of(context).size.width / 4,
                      //       color: Colors.green,
                      //       child: const Text(
                      //         "Create Account",
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const SignUpPage()));
                      //       }),
                      // ),
                      // const Text(
                      //   "Create Account",
                      //   style: TextStyle(color: Colors.white),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 37.0,
                    ),
                    child: Text(
                      "Kinship Tree",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800]),
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
