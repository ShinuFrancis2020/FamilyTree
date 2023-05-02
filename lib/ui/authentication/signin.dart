import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/helper/initializer.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/ui/homescreen.dart';
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
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Helper.pushReplacement(context, const HomeScreen());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: Initializer.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  width: Helper.width(context),
                  child: MaterialButton(
                      color: Colors.green,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (Initializer.formKey.currentState!.validate()) {
                          context.read<MainBloc>().add(DoLogin(
                              username: username.text,
                              password: password.text));
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
