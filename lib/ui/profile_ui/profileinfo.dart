import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
    var d1 = DateFormat('dd-MMM-yyyy');
   @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetProfile());
  }
  @override
  Widget build(BuildContext context) {
    return    BlocConsumer<MainBloc, MainState>(
                  buildWhen: (previous, current) =>
                      current is Fetching ||
                      current is ProfileSuccess ||
                      current is ProfileError,
                  builder: (context, state) {
                    if (state is Fetching) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Helper.loadingindicator(context)],
                            ),
                          ),
                        ),
                      );
                    } else if (state is ProfileSuccess) {
                      return _profieview(state.profileModel);
                      // Column(
                      //   children: [
                      //     Text(state.MyProfileModel.data!.name.toString())
                      //   ],
                      // );
                    }
                    return const SizedBox.shrink();
                  },
                  listener: (context, state) {})
          ;
  }

    _profieview(ProfileModel profileModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height / 3.1,
          //   // color: Colors.green[100],
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/rectanglebg.png'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       const SizedBox(
          //         height: 33,
          //       ),
          //       const Text("efcsasc"),
          //       SizedBox(height: MediaQuery.of(context).size.height / 28.1),
          //       CircleAvatar(
          //         backgroundColor: Colors.blue[200],
          //         radius: 45,
          //         child: const Icon(
          //           Icons.person,
          //           color: Colors.white,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       _text(
          //           profileModel.data!.name.toString(), 20, true, Colors.white),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             SizedBox(
          //                 height: 25,
          //                 // width: 55,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8),
          //                   child: MaterialButton(
          //                       color: Colors.green,
          //                       onPressed: () {},
          //                       child: const Text(
          //                         "Gallery",
          //                         style: TextStyle(
          //                             fontSize: 12, color: Colors.white),
          //                       )),
          //                 )),
          //             const SizedBox(
          //               width: 5,
          //             ),
          //             SizedBox(
          //                 height: 25,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8),
          //                   child: MaterialButton(
          //                       color: Colors.green,
          //                       onPressed: () {},
          //                       child: const Text(
          //                         "Contact",
          //                         style: TextStyle(
          //                             fontSize: 12, color: Colors.white),
          //                       )),
          //                 )),
          //             const SizedBox(
          //               width: 5,
          //             ),
          //             SizedBox(
          //                 height: 25,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8),
          //                   child: MaterialButton(
          //                       color: Colors.green,
          //                       onPressed: () {},
          //                       child: const Text(
          //                         "Photos",
          //                         style: TextStyle(
          //                             fontSize: 12, color: Colors.white),
          //                       )),
          //                 )),
          //             const SizedBox(
          //               width: 5,
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),

          // _sizedbox(20),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 16, right: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("House Name:", 15, true, Colors.black),
                      _text(profileModel.data!.familyId!.familyName.toString(),
                          14, false, Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Phone:", 15, true, Colors.black),
                      _text(profileModel.data!.phone.toString(), 14, false,
                          Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gmail:", 15, true, Colors.black),
                      _text(profileModel.data!.email.toString(), 14, false,
                          Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Address:", 15, true, Colors.black),
                      _text(profileModel.data!.address.toString(), 14, false,
                          Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Date of Birth:", 15, true, Colors.black),
                      _text(
                          d1.format(DateTime.parse(
                            profileModel.data!.dateOfBirth.toString(),
                          )),
                          14,
                          false,
                          Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gender:", 15, true, Colors.black),
                      _text(profileModel.data!.gender.toString(), 14, false,
                          Colors.black),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Marital Status:", 15, true, Colors.black),
                      _text(profileModel.data!.maritalStatus.toString(), 14,
                          false, Colors.black),
                    ],
                  ),
                ),
                profileModel.data!.educationalQualification == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Educational Qualification:", 15, true,
                                Colors.black),
                            _text(
                                profileModel.data!.educationalQualification
                                    .toString(),
                                14,
                                false,
                                Colors.black),
                          ],
                        ),
                      ),
                profileModel.data!.hobbies == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Hobbies:", 15, true, Colors.black),
                            _text(profileModel.data!.hobbies.toString(), 14,
                                false, Colors.black),
                          ],
                        ),
                      ),
                profileModel.data!.currentStatus == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Current Status:", 15, true, Colors.black),
                            _text(profileModel.data!.currentStatus.toString(),
                                14, false, Colors.black),
                          ],
                        ),
                      ),
                profileModel.data!.dateOfDeath == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Date of Death:", 15, true, Colors.black),
                            _text(
                                d1.format(DateTime.parse(
                                  profileModel.data!.dateOfBirth.toString(),
                                )),
                                14,
                                false,
                                Colors.black),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _sizedbox(height) {
    return SizedBox(
      height: double.parse(height.toString()),
    );
  }

  _text(name, size, bool type, Color? color) {
    return Text(
      name,
      style: TextStyle(
          color: color!,
          fontSize: double.parse(
            size.toString(),
          ),
          fontWeight: type == false ? FontWeight.normal : FontWeight.bold),
    );
  }
}