import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return const CircularProgressIndicator();
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 400,
                height: MediaQuery.of(context).size.height / 4,

                // child: Image.asset(
                //   'assets/title.png',
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
          ),
          _text(profileModel.data!.name.toString()),
          _text(profileModel.data!.phone.toString()),
          _text(profileModel.data!.address.toString()),
          _text(profileModel.data!.dateOfBirth.toString()),
        ],
      ),
    );
  }

  _text(name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 18),
    );
  }
}
