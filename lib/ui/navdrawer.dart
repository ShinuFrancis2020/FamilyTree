import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/ui/authentication/signin.dart';
import 'package:family_tree_app/ui/myprofile.dart';
import 'package:family_tree_app/ui/profile_ui/whatsappcall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, right: 60.0, top: 30.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/familyfinallogo.png',
                  width: Helper.width(context) / 2.7,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.black,
            ),
            title: const Text("Home"),
            onTap: () async {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              color: Colors.black,
            ),
            title: const Text("Profile"),
            onTap: () async {
              Helper.push(context, const MyProfile());
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              color: Colors.black,
            ),
            title: const Text("whatsapp"),
            onTap: () async {
              Helper.push(context, const Home());
            },
          ),
          BlocListener<MainBloc, MainState>(
            listener: (context, state) {
              if (state is Loggingout) {
                Helper.loading(context);
              }
              if (state is LogouSuccess) {
                LocalStorage.clearAll();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const Authentication()),
                    ModalRoute.withName('/'));
                // Helper.pop(context);
              }
              if (state is LogoutError || state is LogoutError) {
                Helper.pop(context);
              }
            },
            child: ListTile(
              title: const Text("Logout"),
              leading: const Icon(
                CupertinoIcons.power,
                color: Colors.black,
              ),
              onTap: () async {
                BlocProvider.of<MainBloc>(context).add(DoLogout());
              },
            ),
          ),
        ],
      ),
    );
  }
}
