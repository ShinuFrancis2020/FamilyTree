import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profiledetailedmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileDetailed extends StatefulWidget {
  final String? userId;
  const ProfileDetailed({super.key, this.userId});

  @override
  State<ProfileDetailed> createState() => _ProfileDetailedState();
}

class _ProfileDetailedState extends State<ProfileDetailed> {
  var d1 = DateFormat('dd-MMM-yyyy');
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context)
        .add(GetProfileDetailed(userID: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<MainBloc, MainState>(
                buildWhen: (previous, current) =>
                    current is ProfileDetailedSuccess ||
                    current is ProfileDetailedLoding ||
                    current is ProfileDetailedError,
                builder: (context, state) {
                  if (state is ProfileDetailedLoding) {
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
                  } else if (state is ProfileDetailedSuccess) {
                    return _profieview(state.profileDetailedModel);
                    // Column(
                    //   children: [
                    //     Text(state.profileDetailedModel.data!.name.toString())
                    //   ],
                    // );
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {})
          ],
        ),
      ),
    );
  }

  _profieview(ProfileDetailedModel profileDetailedModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.8,
            color: Colors.green[100],
            child: Column(
              children: [
                const SizedBox(
                  height: 29,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue[200],
                  radius: 45,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                _text(profileDetailedModel.data!.name.toString(), 20, true),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 25,
                          // width: 55,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: MaterialButton(
                                color: Colors.green,
                                onPressed: () {},
                                child: const Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          height: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: MaterialButton(
                                color: Colors.green,
                                onPressed: () {},
                                child: const Text(
                                  "Contact",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          height: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: MaterialButton(
                                color: Colors.green,
                                onPressed: () {},
                                child: const Text(
                                  "Photos",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          _sizedbox(20),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("House Name:", 16, true),
                      _text(
                          profileDetailedModel.data!.familyId!.familyName
                              .toString(),
                          15,
                          false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Phone:", 16, true),
                      _text(profileDetailedModel.data!.phone.toString(), 15,
                          false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gmail:", 16, true),
                      _text(profileDetailedModel.data!.email.toString(), 15,
                          false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Address:", 16, true),
                      _text(profileDetailedModel.data!.address.toString(), 15,
                          false),
                    ],
                  ),
                ),
                profileDetailedModel.data!.dateOfBirth == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Date of Birth:", 16, true),
                            _text(
                                d1.format(DateTime.parse(
                                  profileDetailedModel.data!.dateOfBirth
                                      .toString(),
                                )),
                                15,
                                false),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gender:", 16, true),
                      _text(profileDetailedModel.data!.gender.toString(), 15,
                          false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Marital Status:", 16, true),
                      _text(profileDetailedModel.data!.maritalStatus.toString(),
                          15, false),
                    ],
                  ),
                ),
                profileDetailedModel.data!.educationalQualification == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Educational Qualification:", 16, true),
                            _text(
                                profileDetailedModel
                                    .data!.educationalQualification
                                    .toString(),
                                15,
                                false),
                          ],
                        ),
                      ),
                profileDetailedModel.data!.hobbies == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Hobbies:", 16, true),
                            _text(profileDetailedModel.data!.hobbies.toString(),
                                15, false),
                          ],
                        ),
                      ),
                profileDetailedModel.data!.currentStatus == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Current Status:", 16, true),
                            _text(
                                profileDetailedModel.data!.currentStatus
                                    .toString(),
                                15,
                                false),
                          ],
                        ),
                      ),
                profileDetailedModel.data!.dateOfDeath == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text("Date of Death:", 16, true),
                            _text(
                                d1.format(DateTime.parse(
                                  profileDetailedModel.data!.dateOfBirth
                                      .toString(),
                                )),
                                15,
                                false),
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

  _text(name, size, bool type) {
    return Text(
      name,
      style: TextStyle(
          fontSize: double.parse(
            size.toString(),
          ),
          fontWeight: type == false ? FontWeight.normal : FontWeight.bold),
    );
  }
}
