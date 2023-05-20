import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/ui/familyhomescreen.dart';
import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddParentsForm extends StatefulWidget {
  final String? pagenavname;
  final String? uid;
  const AddParentsForm({super.key, this.pagenavname, this.uid});

  @override
  State<AddParentsForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddParentsForm> {
  bool show = false;
  // static GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final fatheremail = TextEditingController();
  // final password = TextEditingController();
  final fathername = TextEditingController();
  final familyName = TextEditingController();
  final fatherAddress = TextEditingController();
  final fatherPhone = TextEditingController();
  final dateOfBirth = TextEditingController();
  final fatherCurrentStatus = TextEditingController();
  final fatherEducationalQualification = TextEditingController();
  final fatherHobbies = TextEditingController();
  final fatherDateOfBirth = TextEditingController();
  final fatherDateOfDeath = TextEditingController();
  final motherFamilyName = TextEditingController();
  final motherEmail = TextEditingController();
  final motherName = TextEditingController();
  final motherAddress = TextEditingController();
  final motherPhone = TextEditingController();
  final motherEducationalQualification = TextEditingController();
  final motherCurrentStatus = TextEditingController();
  final motherHobbies = TextEditingController();
  final motherDateOfBirth = TextEditingController();
  // final password = TextEditingController();
  final motherDateOfDeath = TextEditingController();

  bool? fathercheck = true;

  @override
  void initState() {
    super.initState();
    // dispose();
  }

  @override
  // void dispose() {
  //   formKey4.currentState?.dispose(); // Release resources
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.pagenavname.toString()),
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: Helper.width(context),
          child: MaterialButton(
              color: Colors.green,
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (Initializer.addparentsdatafromKey.currentState!.validate()) {
                  context.read<MainBloc>().add(AddParentsData(
                        fatherEmail: fatheremail.text.toString(),
                        uid: widget.uid.toString(),
                        fatherName: fathername.text.toString(),
                        fatherAddress: fatherAddress.text.toString(),
                        fatherPhone: fatherPhone.text.toString(),
                        fatherCurrentStatus:
                            fatherCurrentStatus.text.toString(),
                        fatherEducationalQualification:
                            fatherEducationalQualification.text.toString(),
                        fatherHobbies: fatherHobbies.text.toString(),
                        fatherDateOfBirth: fatherDateOfBirth.text.toString(),
                        fatherDateOfDeath: fatherDateOfDeath.text.toString(),
                        motherFamilyName: motherFamilyName.text.toString(),
                        motherEmail: motherEmail.text.toString(),
                        motherName: motherName.text.toString(),
                        motherAddress: motherAddress.text,
                        motherPhone: motherPhone.text.toString(),
                        motherEducationalQualification:
                            motherEducationalQualification.text.toString(),
                        motherCurrentStatus:
                            motherCurrentStatus.text.toString(),
                        motherHobbies: motherHobbies.text.toString(),
                        motherDateOfBirth: motherDateOfBirth.text.toString(),
                        motherDateOfDeath: motherDateOfDeath.text.toString(),
                      ));
                }
              }),
        ),
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is DataAddedSuccefully) {
            Navigator.push(context,
                (MaterialPageRoute(builder: (context) => const FamilyHome())));
            dispose();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: Initializer.addparentsdatafromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: InkWell(
                          child: Container(
                              height: fathercheck != true
                                  ? MediaQuery.of(context).size.height / 6
                                  : MediaQuery.of(context).size.height / 5,
                              width: fathercheck != true
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width / 2,
                              color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 8,
                                  child: CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Colors.yellow,
                                      child: Text(
                                        "F",
                                        style: TextStyle(fontSize: 25),
                                      )),
                                ),
                              )),
                          onTap: () {
                            setState(() {
                              fathercheck = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: InkWell(
                          child: Container(
                              height: fathercheck == true
                                  ? MediaQuery.of(context).size.height / 6
                                  : MediaQuery.of(context).size.height / 5,
                              width: fathercheck == true
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width / 2,
                              color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 8,
                                  child: CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Colors.yellow,
                                      child: Text(
                                        "M",
                                        style: TextStyle(fontSize: 25),
                                      )),
                                ),
                              )

                              //  Icon(
                              //   Icons.person,
                              // ),
                              ),
                          onTap: () {
                            setState(() {
                              fathercheck = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  fathercheck != true
                      ? const SizedBox.shrink()
                      : Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Helper.textformfiled(
                                    "Father Name", fathername, "text", true),
                                Helper.allowHeight(20),
                                Helper.textformfiled(
                                    "Family Email", fatheremail, "text", true),
                                Helper.allowHeight(20),
                                Helper.textformfiled("Father Address",
                                    fatherAddress, "text", true),
                                Helper.allowHeight(20),
                                Helper.textformfiled("Father Phone",
                                    fatherPhone, "number", true),
                                Helper.allowHeight(20),
                                Helper.textformfiled("Status(Current)",
                                    fatherCurrentStatus, "text", false),
                                Helper.allowHeight(20),
                                Helper.textformfiled(
                                    "Educational Qualification",
                                    fatherEducationalQualification,
                                    "text",
                                    false),
                                Helper.allowHeight(20),
                                Helper.textformfiled("Father Hobbies",
                                    fatherHobbies, "text", false),
                                Helper.allowHeight(20),
                                InkWell(
                                  onTap: () async {
                                    DateTime? date = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime(DateTime.now().year - 18),
                                        firstDate:
                                            DateTime(DateTime.now().year - 100),
                                        lastDate:
                                            DateTime(DateTime.now().year));
                                    date = date;
                                    if (date != null) {
                                      fatherDateOfBirth.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(date.toLocal());
                                    }
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: fatherDateOfBirth,
                                      readOnly: true,
                                      //focusNode: Initializer.focusNode[3],
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                        suffixIcon:
                                            const Icon(Icons.calendar_month),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        initialDate:
                                            DateTime(DateTime.now().year - 18),
                                        firstDate:
                                            DateTime(DateTime.now().year - 100),
                                        lastDate:
                                            DateTime(DateTime.now().year));
                                    date = date;
                                    if (date != null) {
                                      fatherDateOfDeath.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(date.toLocal());
                                    }
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: fatherDateOfDeath,
                                      readOnly: true,
                                      //focusNode: Initializer.focusNode[3],
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                        suffixIcon:
                                            const Icon(Icons.calendar_month),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                  fathercheck != false
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Helper.textformfiled(
                                "Mother Name", motherName, "text", true),
                            Helper.allowHeight(20),
                            Helper.textformfiled("Mother Family Name",
                                motherFamilyName, "text", true),
                            Helper.allowHeight(20),
                            Helper.textformfiled(
                                "Mother Email", motherEmail, "text", true),
                            Helper.allowHeight(20),
                            Helper.textformfiled(
                                "Mother Address", motherAddress, "text", true),
                            Helper.allowHeight(20),
                            Helper.textformfiled(
                                "Mother Phone", motherPhone, "number", true),
                            Helper.allowHeight(20),
                            Helper.textformfiled("Status(Current)",
                                motherCurrentStatus, "text", false),
                            Helper.allowHeight(20),
                            Helper.textformfiled("Educational Qualification",
                                motherEducationalQualification, "text", false),
                            Helper.allowHeight(20),
                            Helper.textformfiled(
                                "Mother Hobbies", motherHobbies, "text", false),
                            Helper.allowHeight(20),
                            InkWell(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime(DateTime.now().year - 18),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime(DateTime.now().year));
                                date = date;
                                if (date != null) {
                                  motherDateOfBirth.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(date.toLocal());
                                }
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: motherDateOfBirth,
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
                                    suffixIcon:
                                        const Icon(Icons.calendar_month),
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
                                    initialDate:
                                        DateTime(DateTime.now().year - 18),
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime(DateTime.now().year));
                                date = date;
                                if (date != null) {
                                  motherDateOfDeath.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(date.toLocal());
                                }
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: motherDateOfDeath,
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
                                    suffixIcon:
                                        const Icon(Icons.calendar_month),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textformfiled(hinttext, TextEditingController textcontroller) {
    return TextFormField(
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
      controller: textcontroller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
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
}
