import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:family_tree_app/ui/adddatataform.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatefulWidget {
  final String? userId;
  const MyProfile({super.key, this.userId});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var d1 = DateFormat('dd-MMM-yyyy');
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: ((context, state) {
              if (state is ProfileSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    child: const Icon(Icons.edit),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDataForm(
                                  profileModel: state.profileModel)));
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<MainBloc, MainState>(
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
          ],
        ),
      ),
    );
  }

  _profieview(ProfileModel profileModel) {
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
                _text(profileModel.data!.name.toString(), 20, true),
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
                      _text(profileModel.data!.familyId!.familyName.toString(),
                          15, false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Phone:", 16, true),
                      _text(profileModel.data!.phone.toString(), 15, false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gmail:", 16, true),
                      _text(profileModel.data!.email.toString(), 15, false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Address:", 16, true),
                      _text(profileModel.data!.address.toString(), 15, false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Gender:", 16, true),
                      _text(profileModel.data!.gender.toString(), 15, false),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text("Marital Status:", 16, true),
                      _text(profileModel.data!.maritalStatus.toString(), 15,
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
