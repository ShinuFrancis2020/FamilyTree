import 'package:flutter/material.dart';

class OuterContainer extends StatelessWidget {
  final Widget? child;
  const OuterContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1.0,
            spreadRadius: 1.0),
      ]),
      child: child,
    );
  }
}
