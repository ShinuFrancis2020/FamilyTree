import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/treemodel.dart';
import 'package:family_tree_app/ui/adddatataform.dart';
import 'package:family_tree_app/ui/common/outercontainer.dart';
import 'package:family_tree_app/ui/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyHome extends StatefulWidget {
  const FamilyHome({super.key});

  @override
  State<FamilyHome> createState() => _RoughPageState();
}

class _RoughPageState extends State<FamilyHome> {
  @override
  void initState() {
    super.initState();

    context.read<MainBloc>().add(GetUser(userID: 'nill'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Family Tree"),
          elevation: 0,
        ),
        drawer: const HomeDrawer(),
        body: BlocBuilder<MainBloc, MainState>(
            buildWhen: ((previous, current) => current is UserFetched),
            builder: (context, state) {
              if (state is UserFetched) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: List.generate(
                        //         Initializer.generations.generations.length,
                        //         (index) => Row(
                        //               children: [
                        //                 InkWell(
                        //                   onTap: () => context
                        //                       .read<MainBloc>()
                        //                       .add(ShowGenerations(index: index)),
                        //                   child: Container(
                        //                     width: 100,
                        //                     padding: const EdgeInsets.all(14.0),
                        //                     decoration: BoxDecoration(
                        //                         color: Colors.white,
                        //                         borderRadius:
                        //                             BorderRadius.circular(8.0),
                        //                         boxShadow: [
                        //                           BoxShadow(
                        //                               color: Colors.grey
                        //                                   .withOpacity(0.5)),
                        //                         ]),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       mainAxisSize: MainAxisSize.min,
                        //                       children: [
                        //                         Text(
                        //                           "G${index + 1}",
                        //                           style: const TextStyle(
                        //                               color: Colors.black,
                        //                               fontWeight: FontWeight.bold,
                        //                               fontSize: 18),
                        //                         ),
                        //                         Helper.allowWidth(10),
                        //                         const Icon(Icons.arrow_right)
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Helper.allowWidth(10),
                        //               ],
                        //             )),
                        //   ),
                        // ),
                        // Helper.allowHeight(20),
                        buildRelation(state.treeModel)
                      ],
                    ),
                  ),
                );
              }
              return const LinearProgressIndicator();
            }));
  }

  buildRelation(TreeModel treeModel) {
    if (treeModel.data!.fatherId != null && treeModel.data!.motherId != null) {
      if (treeModel.data!.spouseId != null) {
        if (treeModel.data!.childrens!.isNotEmpty) {
          // return buildSpouseWithChildren(treeModel);
          return buildParentWithChildAndGrandChilds(treeModel);
        } else {
          // return buildSpouseOnly(treeModel);
          return buildParentWithChild(treeModel, false);
        }
      } else {
        // return buildSpouseWithChildren(treeModel);
        return buildParentWithChild(treeModel, true);
      }
    } else {
      if (treeModel.data!.spouseId != null) {
        if (treeModel.data!.childrens!.isNotEmpty) {
          return buildSpouseWithChildren(treeModel);
        } else {
          return buildSpouseOnly(treeModel);
        }
      } else {
        return addMember(treeModel);
      }
    }
  }

  addMember(TreeModel treeModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: context.read<MainBloc>().adddata == false ? 55 : 65,
                backgroundColor: Colors.blue,
                child: InkWell(
                  child: RippleAnimation(
                    repeat: true,
                    color: Colors.blue,
                    minRadius: 70,
                    ripplesCount: 5,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.blue,
                      child: Text(
                        treeModel.data!.name.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<MainBloc>().adddata == true
                        ? context.read<MainBloc>().adddata = false
                        : context.read<MainBloc>().adddata = true;

                    context.read<MainBloc>().add(GetUser(userID: 'nill'));

                    context.read<MainBloc>().adddata == true
                        ? _showDialog(context, treeModel.data!.sId.toString(),
                            false, false)
                        : "";
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showDialog(BuildContext context, uid, spousepresent, childpresent) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          // title: const Text(
          //     "Do you want to delete the site  "),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _generatecontainer(
                              35, 60, "Spouse", spousepresent, uid),
                          const SizedBox(
                            width: 20,
                          ),
                          _generatecontainer(35, 60, "Parents", false, uid),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _generatecontainer(
                              35, 60, "Children", childpresent, uid),
                          const SizedBox(
                            width: 20,
                          ),
                          _generatecontainer(35, 60, "Photos", true, uid),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            MaterialButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);

                  context.read<MainBloc>().adddata == true
                      ? context.read<MainBloc>().adddata = false
                      : context.read<MainBloc>().adddata = true;

                  context.read<MainBloc>().add(GetUser(userID: 'nill'));
                })
          ],
        );
      },
    );
  }

  Widget _generatecontainer(
      double height, double width, String? name, bool? enable, String? uid) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: enable == false ? Colors.grey : Colors.blue,
        ),
        height: height,
        // width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name.toString(),
              style: const TextStyle(color: Colors.white)),
        ),
      ),
      onTap: () {
        enable == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddDataForm(
                        pagenavname: name.toString(), uid: uid.toString())))
            : "";
      },
    );
  }

  Widget buildSpouseWithChildren(TreeModel treeModel) {
    return Column(
      children: [
        OuterContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => {
                  context.read<MainBloc>().adddata == true
                      ? context.read<MainBloc>().adddata = false
                      : context.read<MainBloc>().adddata = true,
                  context.read<MainBloc>().add(GetUser(userID: 'nill')),
                  context.read<MainBloc>().adddata == true
                      ? _showDialog(context, treeModel.data!.sId.toString(),
                          treeModel.data!.spouseId == null ? true : false, true)
                      : "",
                },
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      color: treeModel.data!.amI == true
                          ? Colors.green
                          : Colors.blueAccent,
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
              Helper.hDivider(width: 40.0),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    color: treeModel.data!.spouseId!.amI == true
                        ? Colors.green
                        : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5)),
                    ]),
                child: Text(
                  treeModel.data!.spouseId!.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Helper.vDivider(height: 120.0),
        OuterContainer(
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
        OuterContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => {
                  context.read<MainBloc>().adddata == true
                      ? context.read<MainBloc>().adddata = false
                      : context.read<MainBloc>().adddata = true,
                  context.read<MainBloc>().add(GetUser(userID: 'nill')),
                  context.read<MainBloc>().adddata == true
                      ? _showDialog(
                          context,
                          treeModel.data!.sId.toString(),
                          treeModel.data!.spouseId == null ? true : false,
                          treeModel.data!.childrens!.isEmpty ? true : false)
                      : "",
                },
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    treeModel.data!.name!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              Helper.hDivider(width: 55.0),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  treeModel.data!.spouseId!.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildParentWithChildAndGrandChilds(TreeModel treeModel) {
    //   return Column(
    //     children: [
    //       OuterContainer(
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 InkWell(
    //                   onTap: () => {},
    //                   child: Container(
    //                     padding: const EdgeInsets.all(14.0),
    //                     decoration: BoxDecoration(
    //                         color: Colors.blueAccent,
    //                         borderRadius: BorderRadius.circular(18.0),
    //                         boxShadow: [
    //                           BoxShadow(color: Colors.grey.withOpacity(0.5)),
    //                         ]),
    //                     child: Text(
    //                       treeModel.data!.fatherId!.name!,
    //                       style: const TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16),
    //                     ),
    //                   ),
    //                 ),
    //                 Helper.hDivider(width: 120.0),
    //                 Container(
    //                   padding: const EdgeInsets.all(14.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.blueAccent,
    //                       borderRadius: BorderRadius.circular(18.0),
    //                       boxShadow: [
    //                         BoxShadow(color: Colors.grey.withOpacity(0.5)),
    //                       ]),
    //                   child: Flexible(
    //                     child: Text(
    //                       treeModel.data!.motherId!.name!,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Helper.allowHeight(10),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 InkWell(
    //                   onTap: () => {},
    //                   child: Container(
    //                     padding: const EdgeInsets.all(14.0),
    //                     decoration: BoxDecoration(
    //                         color: Colors.blueAccent,
    //                         borderRadius: BorderRadius.circular(18.0),
    //                         boxShadow: [
    //                           BoxShadow(color: Colors.grey.withOpacity(0.5)),
    //                         ]),
    //                     child: Text(
    //                       treeModel.data!.name!,
    //                       style: const TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16),
    //                     ),
    //                   ),
    //                 ),
    //                 Helper.hDivider(width: 120.0),
    //                 Container(
    //                   padding: const EdgeInsets.all(14.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.blueAccent,
    //                       borderRadius: BorderRadius.circular(18.0),
    //                       boxShadow: [
    //                         BoxShadow(color: Colors.grey.withOpacity(0.5)),
    //                       ]),
    //                   child: Flexible(
    //                     child: Text(
    //                       treeModel.data!.spouseId!.name!,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       Helper.vDivider(height: 120.0),
    //       OuterContainer(
    //         child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             mainAxisSize: MainAxisSize.max,
    //             children: List.generate(
    //               treeModel.data!.childrens!.length,
    //               (indexOne) => InkWell(
    //                 onTap: () => treeModel
    //                             .data!.childrens![indexOne].maritalStatus !=
    //                         "Single"
    //                     ? context.read<MainBloc>().add(GetUser(
    //                         userID: treeModel.data!.childrens![indexOne].sId))
    //                     : Helper.showToast(
    //                         msg: treeModel
    //                             .data!.childrens![indexOne].maritalStatus),
    //                 child: Container(
    //                   padding: const EdgeInsets.all(14.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.blueAccent,
    //                       borderRadius: BorderRadius.circular(18.0),
    //                       boxShadow: [
    //                         BoxShadow(color: Colors.grey.withOpacity(0.5)),
    //                       ]),
    //                   child: Text(
    //                     treeModel.data!.childrens![indexOne].name!,
    //                     style: const TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 16),
    //                   ),
    //                 ),
    //               ),
    //             )),
    //       ),
    //     ],
    //   );
    return Column(
      children: [
        OuterContainer(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => context.read<MainBloc>().add(
                            GetUser(userID: treeModel.data!.fatherId!.sId)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${treeModel.data!.fatherId!.name}",
                            style: TextStyle(
                                color: treeModel.data!.fatherId!.amI == true
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Helper.allowWidth(10),
                      InkWell(
                        onTap: () => context.read<MainBloc>().add(
                            GetUser(userID: treeModel.data!.fatherId!.sId)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${treeModel.data!.motherId!.name}",
                            style: TextStyle(
                                color: treeModel.data!.motherId!.amI == true
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Helper.allowHeight(5),
                  Helper.vDivider(height: 20.0),
                  Helper.allowHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                      Helper.hDivider(width: 30.0),
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
                            treeModel.data!.spouseId!.name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Container(
              //   padding: const EdgeInsets.all(14.0),
              //   decoration: BoxDecoration(
              //       color: Colors.blueAccent,
              //       borderRadius: BorderRadius.circular(18.0),
              //       boxShadow: [
              //         BoxShadow(color: Colors.grey.withOpacity(0.5)),
              //       ]),
              //   child: Flexible(
              //     child: Text(
              //       treeModel.data!.spouseId!.name!,
              //       overflow: TextOverflow.ellipsis,
              //       style: const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Helper.vDivider(height: 60.0),
        OuterContainer(
            child: Row(
          children: List.generate(
              treeModel.data!.childrens!.length,
              (index) => Row(
                    children: [
                      InkWell(
                        onTap: () => treeModel
                                    .data!.childrens![index].maritalStatus !=
                                "Single"
                            ? context.read<MainBloc>().add(GetUser(
                                userID: treeModel.data!.childrens![index].sId))
                            : Helper.showToast(
                                msg: treeModel
                                    .data!.childrens![index].maritalStatus),
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(18.0),
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5)),
                              ]),
                          child: Text(
                            treeModel.data!.childrens![index].name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Helper.allowWidth(10),
                    ],
                  )),
        ))
      ],
    );
  }

  buildParentWithChild(TreeModel treeModel, bool? issingle) {
    return Column(
      children: [
        OuterContainer(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Father - ${treeModel.data!.fatherId!.name}\nMother - ${treeModel.data!.motherId!.name}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    onTap: () {},
                  ),
                  Helper.allowHeight(5),
                  Helper.vDivider(height: 20.0),
                  Helper.allowHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                      Helper.hDivider(width: 80.0),
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
                          child: treeModel.data!.spouseId == null
                              ? const SizedBox.shrink()
                              : Text(
                                  treeModel.data!.spouseId!.name!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Container(
              //   padding: const EdgeInsets.all(14.0),
              //   decoration: BoxDecoration(
              //       color: Colors.blueAccent,
              //       borderRadius: BorderRadius.circular(18.0),
              //       boxShadow: [
              //         BoxShadow(color: Colors.grey.withOpacity(0.5)),
              //       ]),
              //   child: Flexible(
              //     child: Text(
              //       treeModel.data!.spouseId!.name!,
              //       overflow: TextOverflow.ellipsis,
              //       style: const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
