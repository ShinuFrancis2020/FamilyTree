import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/treemodel.dart';
import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoughPage extends StatefulWidget {
  const RoughPage({super.key});

  @override
  State<RoughPage> createState() => _RoughPageState();
}

class _RoughPageState extends State<RoughPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(GetUser(userID: '6450b84dd476264984b74249'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Family Tree"),
        ),
        body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          if (state is UserFetched) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          Initializer.generations.generations.length,
                          (index) => Row(
                                children: [
                                  InkWell(
                                    onTap: ()=>context.read<MainBloc>().add(ShowGenerations(index: index)),
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(14.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(0.5)),
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "G${index + 1}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Helper.allowWidth(10),
                                          const Icon(Icons.arrow_right)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Helper.allowWidth(10),
                                ],
                              )),
                    ),
                  ),
                  Helper.allowHeight(20),
                  buildRelation(state.treeModel)
                ],
              ),
            );
          }
          return const LinearProgressIndicator();
        })
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 30.0),
        //       child: Center(
        //         child: Container(
        //           height: 70,
        //           width: 99,
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
        //                   width: 20,
        //                   child: Divider(
        //                     height: 2,
        //                     color: Colors.black,
        //                   ),
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
        //           width: 99,
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
        //                   width: 20,
        //                   child: Divider(
        //                     height: 2,
        //                     color: Colors.black,
        //                   ),
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

  buildRelation(TreeModel treeModel) {
    if (treeModel.data!.spouseId != null) {
      if (treeModel.data!.childrens!.isNotEmpty) {
        return buildSpouseWithChildren(treeModel);
      } else {
        return buildSpouseOnly(treeModel);
      }
    }
  }

  addMember() {}

  Widget buildSpouseWithChildren(TreeModel treeModel) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => {},
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5)),
                        ]),
                    child: Text(
                      treeModel.data!.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 120, child: Divider(color: Colors.black)),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5)),
                      ]),
                  child: Flexible(
                    child: Text(
                      treeModel.data!.spouseId!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Helper.allowHeight(20),
        const SizedBox(
            height: 60,
            child: VerticalDivider(
              thickness: 2.5,
              color: Colors.black,
            )),

        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                treeModel.data!.childrens!.length,
                (indexOne) => InkWell(
                  onTap: () => treeModel
                              .data!.childrens![indexOne].maritalStatus !=
                          "Single"
                      ? context.read<MainBloc>().add(GetUser(
                          userID: treeModel.data!.childrens![indexOne].sId))
                      : Helper.showToast(
                          msg: treeModel
                              .data!.childrens![indexOne].maritalStatus),
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5)),
                        ]),
                    child: Text(
                      treeModel.data!.childrens![indexOne].name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget buildSpouseOnly(TreeModel treeModel) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => {},
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5)),
                        ]),
                    child: Text(
                      treeModel.data!.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 120, child: Divider(color: Colors.black)),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5)),
                      ]),
                  child: Flexible(
                    child: Text(
                      treeModel.data!.spouseId!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
