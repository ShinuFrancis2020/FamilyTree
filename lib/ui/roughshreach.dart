import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/treemodel.dart';
import 'package:family_tree_app/ui/common/outercontainer.dart';
import 'package:family_tree_app/ui/navdrawer.dart';
import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoughPage extends StatefulWidget {
  const RoughPage({super.key});

  @override
  State<RoughPage> createState() => _RoughPageState();
}

class _RoughPageState extends State<RoughPage> {
  String? uid;
  @override
  void initState() {
    super.initState();
    fetcher();
  }

  fetcher() async {
    uid = await LocalStorage.getUserId();
    print(uid.toString());
    initfunc();
  }

  initfunc() async {
    context.read<MainBloc>().add(GetUser(userID: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Family Tree"),
        ),
        drawer: const HomeDrawer(),
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
                                    onTap: () => context
                                        .read<MainBloc>()
                                        .add(ShowGenerations(index: index)),
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(14.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
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
          return buildParentWithChild(treeModel);
        }
      } else {
        // return buildSpouseWithChildren(treeModel);
        return buildParentWithChild(treeModel);
      }
    } else {
      if (treeModel.data!.spouseId != null) {
        if (treeModel.data!.childrens!.isNotEmpty) {
          return buildSpouseWithChildren(treeModel);
        } else {
          return buildSpouseOnly(treeModel);
        }
      }
    } 
  }

  addMember() {}

  Widget buildSpouseWithChildren(TreeModel treeModel) {
    return Column(
      children: [
        OuterContainer(
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
                Helper.hDivider(width: 120.0),
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
                Helper.hDivider(width: 120.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
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

  Widget buildParentWithChildAndGrandChilds(TreeModel treeModel) {
    return Column(
      children: [
        OuterContainer(
          child: Column(
            children: [
              Row(
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
                        treeModel.data!.fatherId!.name!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Helper.hDivider(width: 120.0),
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
                        treeModel.data!.motherId!.name!,
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
              Helper.allowHeight(10),
              Row(
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
                  Helper.hDivider(width: 120.0),
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

  buildParentWithChild(TreeModel treeModel) {
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
                  Container(
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
      ],
    );
  }
}
