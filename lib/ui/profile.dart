import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var d1 = DateFormat('dd-MMM-yyyy');
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        elevation: 0,
      ),
      body: BlocConsumer<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            current is Fetching ||
            current is ProfileSuccess ||
            current is ProfileError,
        listenWhen: (previous, current) =>
            current is Fetching ||
            current is ProfileSuccess ||
            current is ProfileError,
        builder: (context, state) {
          if (state is Fetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            return _profieview(state.profileModel);
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {},
      ),
    );
  }

  _profieview(ProfileModel profileModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Helper.myprofilecard(
          //     context, "assets/images/profiles/profile1.png", "Vimal", "Male"),
          _sizedbox(35),
          const CircleAvatar(
            // backgroundColor: Colors.blueGrey[800],
            radius: 45,
            backgroundImage: AssetImage("assets/family.png"),
            child: Icon(Icons.person),
          ),
          _sizedbox(50),
          // const SizedBox(
          //   width: 180,
          //   child: Divider(
          //     color: Colors.black,
          //   ),
          // ),
          _text(
            profileModel.data!.name.toString(),
            24,
          ),
          Helper.allowHeight(20),
          _text(profileModel.data!.phone.toString(), 18),
          Helper.allowHeight(20),
          _text(profileModel.data!.address.toString(), 18),
          Helper.allowHeight(20),
          _text(profileModel.data!.gender.toString(), 18),
          Helper.allowHeight(20),
          _text(profileModel.data!.maritalStatus.toString(), 18),
          Helper.allowHeight(20),
          _text(
              d1.format(DateTime.parse(
                profileModel.data!.dateOfBirth.toString(),
              )),
              16),
        ],
      ),
    );
  }

  _sizedbox(height) {
    return SizedBox(
      height: double.parse(height.toString()),
    );
  }

  _text(name, size) {
    return Text(
      name,
      style: TextStyle(
          fontSize: double.parse(
            size.toString(),
          ),
          fontWeight: FontWeight.bold),
    );
  }
}
