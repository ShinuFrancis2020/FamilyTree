import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/utils/initializer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool show = false;
  static List<String> genderlist = ["Male", "Female"];
  static String? selectedGender = 'Male';
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final familyName = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final dateOfBirth = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Add Account"),
        elevation: 0,
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            // Helper.pushReplacement(context, const Authentication());
            Helper.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: Initializer.registerKey,
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
                    controller: name,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[50],
                      labelText: "Name",
                      // labelStyle: AppStyles.buttonloginText,
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
                    controller: email,
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
                    controller: familyName,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[50],
                      labelText: "Family Name",
                      // labelStyle: AppStyles.buttonloginText,
                    ),
                  ),
                  Helper.allowHeight(20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      // border: Border.all()
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[50],
                    ),
                    child: BlocBuilder<MainBloc, MainState>(
                      buildWhen: (previous, current) =>
                          current is GenderChangedState,
                      builder: ((context, state) {
                        return DropdownButton<String>(
                          value: selectedGender,
                          items: genderlist
                              .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                              .toList(),
                          onChanged: (value) {
                            context.read<MainBloc>().add(GenderChanged());
                            selectedGender = value;
                          },
                          hint: const Text('Select an option'),
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          itemHeight: 56.0,
                          elevation: 0,
                          isDense: true,
                        );
                      }),
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
                    controller: address,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[50],
                      labelText: "Address",
                      // labelStyle: AppStyles.buttonloginText,
                    ),
                  ),
                  Helper.allowHeight(20),
                  TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
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
                    controller: phone,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[50],
                      labelText: "Phone",
                      // labelStyle: AppStyles.buttonloginText,
                    ),
                  ),
                  Helper.allowHeight(20),
                  InkWell(
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year - 18),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year - 18));
                      date = date;
                      if (date != null) {
                        dateOfBirth.text =
                            DateFormat('yyyy-MM-dd').format(date.toLocal());
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: dateOfBirth,
                        readOnly: true,
                        //focusNode: Initializer.focusNode[3],
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,

                        // controller: controller,
                        // validator: (value) {
                        //   if (!value!.contains('@') || value.isEmpty) {
                        //     return 'Please enter a valid email address.';
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          hintText: "Date of Birth",
                          suffixIcon: const Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[50],
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Helper.allowHeight(20),
                  SizedBox(
                    width: Helper.width(context),
                    child: MaterialButton(
                        color: Colors.green,
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (Initializer.registerKey.currentState!
                              .validate()) {
                            context.read<MainBloc>().add(Signup(
                                  gender: selectedGender.toString(),
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  familyName: familyName.text,
                                  address: address.text,
                                  phone: phone.text,
                                  dateOfBirth: dateOfBirth.text,
                                ));
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
