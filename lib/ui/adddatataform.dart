import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';

import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddDataForm extends StatefulWidget {
  final String? pagenavname;
  final ProfileModel? profileModel;
  final String? uid;
  const AddDataForm({super.key, this.pagenavname, this.uid, this.profileModel});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  bool show = false;
  // GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  static List<String> genderlist = ["Male", "Female"];
  static String? selectedGender = 'Male';
  final email = TextEditingController();

  // final password = TextEditingController();
  final name = TextEditingController();
  final familyName = TextEditingController();

  final address = TextEditingController();
  final phone = TextEditingController();
  final dateOfBirth = TextEditingController();

  final currentStatus = TextEditingController();
  final educationalQualification = TextEditingController();
  final hobbies = TextEditingController();

  final dateOfDeath = TextEditingController();

  @override
  @override
  void initState() {
    widget.profileModel == null ? "" : _editprofile();
    super.initState();
    // dispose();
  }

  _editprofile() {
    email.text = widget.profileModel!.data!.email.toString();

    name.text = widget.profileModel!.data!.name.toString();

    familyName.text = "";

    address.text = widget.profileModel!.data!.address.toString();
    phone.text = widget.profileModel!.data!.phone.toString();

    dateOfBirth.text = widget.profileModel!.data!.dateOfBirth.toString();
    currentStatus.text = widget.profileModel!.data!.currentStatus != null
        ? widget.profileModel!.data!.currentStatus.toString()
        : "";

    educationalQualification.text =
        widget.profileModel!.data!.educationalQualification != null
            ? widget.profileModel!.data!.educationalQualification.toString()
            : "";
    hobbies.text = widget.profileModel!.data!.hobbies != null
        ? widget.profileModel!.data!.hobbies.toString()
        : "";

    dateOfDeath.text = widget.profileModel!.data!.dateOfDeath != null
        ? widget.profileModel!.data!.dateOfDeath.toString()
        : "";
  }

  @override
  void dispose() {
    // formKey3.currentState?.dispose();
    // setState(() {});
// Release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: widget.profileModel == null
            ? Text(widget.pagenavname.toString())
            : const Text("Edit Profile"),
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: Helper.width(context),
          child: MaterialButton(
              color: Colors.green,
              child: Text(
                widget.profileModel == null ? "Register" : "Edit",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (Initializer.adddatafromKey.currentState!.validate()) {
                  context.read<MainBloc>().add(AddFormData(
                        editboolean: widget.profileModel != null ? true : false,
                        routename: widget.pagenavname.toString(),
                        uid: widget.uid.toString(),
                        gender: widget.profileModel == null
                            ? selectedGender.toString()
                            : "nill",
                        email: email.text,
                        password: "",
                        name: name.text,
                        familyName: familyName.text,
                        address: address.text,
                        phone: phone.text,
                        dateOfBirth: dateOfBirth.text,
                        educationalQualification:
                            educationalQualification.text.toString(),
                        currentStatus: currentStatus.text.toString(),
                        hobbies: hobbies.text.toString(),
                        dateOfDeath: dateOfDeath.text.toString(),
                      ));
                }
              }),
        ),
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) async {
          if (state is DataAddedSuccefully) {
            Navigator.pop(context);
            // Navigator.push(context,
            //     (MaterialPageRoute(builder: (context) => const FamilyHome())));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: Initializer.adddatafromKey,
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
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : Helper.allowHeight(20),
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : TextFormField(
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
                  widget.pagenavname == "Children"
                      ? const SizedBox.shrink()
                      : Helper.allowHeight(20),
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : widget.pagenavname == "Children"
                          ? const SizedBox.shrink()
                          : TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : Helper.allowHeight(20),
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : Container(
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
                  widget.profileModel != null
                      ? const SizedBox.shrink()
                      : Helper.allowHeight(20),
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
                  Helper.textformfiled(
                      "Status(Current)", currentStatus, "text", false),
                  Helper.allowHeight(20),
                  Helper.textformfiled("Educational Qualification",
                      educationalQualification, "text", false),
                  Helper.allowHeight(20),
                  Helper.textformfiled(" Hobbies", hobbies, "text", false),
                  Helper.allowHeight(20),
                  InkWell(
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year - 18),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year));
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
                  InkWell(
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year - 18),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year));
                      date = date;
                      if (date != null) {
                        dateOfDeath.text =
                            DateFormat('yyyy-MM-dd').format(date.toLocal());
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: dateOfDeath,
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
                          hintText: "Date of Death",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
