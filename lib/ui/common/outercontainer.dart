import 'package:flutter/material.dart';

class OuterContainer extends StatelessWidget {
  final Widget? child;
  const OuterContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      ////color to transperent from white
      ///grey opacity to white opacity
      ///opacity .5 to .1
      ///
      decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1.0,
            spreadRadius: 1.0),
      ]),
      child: child,
    );
  }
}
