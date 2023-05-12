

import 'package:family_tree_app/logic/bloc/authbloc/authbloc/authbloc.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/bloc/signupbloc/signupbloc.dart';
import 'package:family_tree_app/ui/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (BuildContext context) => MainBloc()),
                BlocProvider<SignupBloc>(create: (BuildContext context) => SignupBloc()),
                     BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[800])),
        home: const SplashScreen(),
      ),
    );
  }
}
