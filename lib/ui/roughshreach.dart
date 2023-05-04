import 'package:flutter/material.dart';

class Rough extends StatefulWidget {
  const Rough({super.key});

  @override
  State<Rough> createState() => _RoughState();
}

class _RoughState extends State<Rough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Tree"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(
          //   padding: EdgeInsets.all(14.0),
          //   child: Text("Me"),
          //   decoration: BoxDecoration(
          //     color: Colors.white, 
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(05),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      // // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(top: 30.0),
      //       child: Center(
      //         child: Container(
      //           height: 70,
      //           width: 200,
      //           color: Colors.green,
      //           child: Padding(
      //             padding: const EdgeInsets.all(18.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Container(
      //                   height: 40,
      //                   width: 40,
      //                   color: Colors.blue,
      //                 ),
      //                 const SizedBox(
      //                   width: 80,
      //                   child: Divider(
      //                     height: 2,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 40,
      //                   width: 40,
      //                   color: Colors.blue,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //       width: 30,
      //       child: VerticalDivider(
      //         color: Colors.black,
      //         thickness: 2,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 0.0),
      //       child: Center(
      //         child: Container(
      //           height: 70,
      //           width: 150,
      //           color: Colors.green,
      //           child: Padding(
      //             padding: const EdgeInsets.all(18.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Container(
      //                   height: 40,
      //                   width: 40,
      //                   color: Colors.blue,
      //                 ),
      //                 const SizedBox(
      //                   width: 30,
      //                   child: Divider(
      //                     height: 2,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 40,
      //                   width: 40,
      //                   color: Colors.blue,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //       width: 30,
      //       child: VerticalDivider(
      //         color: Colors.black,
      //         thickness: 2,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 0.0),
      //       child: Center(
      //         child: Container(
      //           height: 70,
      //           width: 120,
      //           color: Colors.green,
      //           child: Padding(
      //             padding: const EdgeInsets.all(18.0),
      //             child: Row(
      //               children: [
      //                 Container(
      //                   height: 20,
      //                   width: 20,
      //                   color: Colors.blue,
      //                 ),
      //                 const SizedBox(
      //                   width: 8,
      //                 ),
      //                 // const SizedBox(
      //                 //   width: 20,
      //                 //   child: Divider(
      //                 //     height: 2,
      //                 //     color: Colors.black,
      //                 //   ),
      //                 // ),
      //                 Container(
      //                   height: 20,
      //                   width: 20,
      //                   color: Colors.blue,
      //                 ),
      //                 const SizedBox(
      //                   width: 8,
      //                 ),
      //                 Container(
      //                   height: 20,
      //                   width: 20,
      //                   color: Colors.blue,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
