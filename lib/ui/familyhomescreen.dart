import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/logic/bloc/commonbloc.dart';
import 'package:family_tree_app/logic/models/treemodel.dart';
import 'package:family_tree_app/ui/common/outercontainer.dart';
import 'package:family_tree_app/ui/myprofile.dart';
import 'package:family_tree_app/ui/navdrawer.dart';
import 'package:family_tree_app/ui/profiledetailed.dart';
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
    GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
    void _openDrawer() {
      scaffoldKey.currentState!.openDrawer();
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: const Color(0xff2b8dd4),
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 13.0),
              child: InkWell(
                  onTap: _openDrawer,
                  child: const Icon(
                    Icons.menu,
                  )),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 13.0),
              child: Helper.text(
                  "Kinship Tree", 20, Colors.white, FontWeight.w100, 0),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0, right: 30),
                child: Row(
                  children: [
                    InkWell(
                      child:
                          Image.asset("assets/images/profile.png", height: 18),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile(
                                    userId: "2123",
                                    name: "acs",
                                    image:
                                        "assets/images/profiles/profile1.png",
                                    familyname: "Kottaram")));
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child:
                          Image.asset("assets/images/calendar.png", height: 18),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MyProfile()));
                      },
                    ),
                  ],
                ),
              ),
            ],
            elevation: 0,
          ),
        ),
        drawer: const HomeDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/g11.png'),
              fit: BoxFit.none,
            ),
          ),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height / 1,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Colors.white,
            //       Colors.green,
            //       Colors.green,
            //     ],
            //   ),
            // ),
            child: BlocBuilder<MainBloc, MainState>(
                buildWhen: ((previous, current) => current is UserFetched),
                builder: (context, state) {
                  if (state is UserFetched) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    child: Image.asset("assets/images/home.png",
                                        height: 20),
                                    onTap: () {
                                      context
                                          .read<MainBloc>()
                                          .add(GetUser(userID: 'nill'));
                                    },
                                  ),
                                )),
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
                }),
          ),
        ));
  }

  buildRelation(TreeModel treeModel) {
    if (treeModel.data!.fatherId != null && treeModel.data!.motherId != null) {
      if (treeModel.data!.spouseId != null) {
        if (treeModel.data!.childrens!.isNotEmpty) {
          // return buildSpouseWithChildren(treeModel);
          return buildParentWithChildAndGrandChilds(treeModel);

          //  return SizedBox.shrink()
        } else {
          // return buildSpouseOnly(treeModel);
          // return buildParentWithChild(treeModel, false);
          return buildParentWithChildWithSpouse(treeModel);
          // return const SizedBox.shrink();
        }
      } else {
        return buildParentWithChild(treeModel, false);
        // return SizedBox.shrink();
      }
    } else {
      if (treeModel.data!.spouseId != null) {
        if (treeModel.data!.childrens!.isNotEmpty) {
          // return SizedBox.shrink();
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
          height: MediaQuery.of(context).size.height / 3.9,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.green,
            child: Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
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
                    Helper.showAdd(context, treeModel.data!.sId.toString(),
                        true, false, true);
                    // context.read<MainBloc>().adddata == true
                    //     ? context.read<MainBloc>().adddata = false
                    //     : context.read<MainBloc>().adddata = true;

                    // context.read<MainBloc>().add(GetUser(userID: 'nill'));

                    // context.read<MainBloc>().adddata == true
                    //     ? Helper.showAdd(context, treeModel.data!.sId.toString(),
                    //         true, false, true)
                    // //     : "";
                  },
                ),
              ),
            ),
          ),
        ),
      ],
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
                // onTap: () => {},
                onTap: () => {
                  // treeModel.data!.amI == true
                  //     ? Helper.showAdd(
                  //         context,
                  //         treeModel.data!.sId.toString(),
                  //         treeModel.data!.spouseId == null ? true : false,
                  //         true,
                  //         treeModel.data!.familyId == null ? true : false)
                  //     :

                  context
                      .read<MainBloc>()
                      .add(GetUser(userID: treeModel.data!.sId)),
                  // Helper.showDialog(context, treeModel.data!.sId.toString(),
                  //         treeModel.data!.spouseId == null ? true : false, true)
                  // context.read<MainBloc>().adddata == true
                  //     ? context.read<MainBloc>().adddata = false
                  //     : context.read<MainBloc>().adddata = true,
                  // context.read<MainBloc>().add(GetUser(userID: 'nill')),
                  // context.read<MainBloc>().adddata == true
                  //     ? _showDialog(context, treeModel.data!.sId.toString(),
                  //         treeModel.data!.spouseId == null ? true : false, true)
                  //     : "",
                },
                child: Helper.myprofilecard(
                    context,
                    "assets/images/profiles/profile8.png",
                    treeModel.data!.sId,
                    treeModel.data!.name!,
                    treeModel.data!.gender,
                    treeModel.data!.maritalStatus == "Single" ? true : false,
                    treeModel.data!.amI,
                    treeModel.data!.isRoot,
                    "You",
                    treeModel.data!.fatherId != null ? true : false,
                    treeModel.data!.mainFamilyId!.familyName,
                    false),

                // Column(
                //   children: [
                //     InkWell(
                //       child: Container(
                //         width: MediaQuery.of(context).size.width / 3,
                //         padding: const EdgeInsets.all(14.0),
                //         decoration: BoxDecoration(
                //             color: treeModel.data!.amI == true
                //                 ? Colors.blue
                //                 : Colors.blue[200],
                //             borderRadius: const BorderRadius.only(
                //                 topLeft: Radius.circular(18),
                //                 topRight: Radius.circular(18)),
                //             boxShadow: [
                //               BoxShadow(color: Colors.grey.withOpacity(0.5)),
                //             ]),
                //         child: Stack(
                //           children: [
                //             Column(
                //               children: [
                //                 const CircleAvatar(
                //                   backgroundImage:
                //                       AssetImage("assets/familyilogo.jpg"),
                //                   backgroundColor: Colors.grey,
                //                 ),
                //                 SizedBox(
                //                   height: 20,
                //                   child: Text(
                //                     treeModel.data!.name!,
                //                     style: const TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 15),
                //                   ),
                //                 ),
                //                 const SizedBox(
                //                   height: 2,
                //                 ),
                //               ],
                //             ),
                //             treeModel.data!.amI != true ||
                //                     treeModel.data!.isRoot != true
                //                 ? const SizedBox.shrink()
                //                 : Positioned(
                //                     left: 70,
                //                     child: InkWell(
                //                       child: const CircleAvatar(
                //                         backgroundColor: Colors.green,
                //                         radius: 11,
                //                         child: Icon(
                //                           Icons.add,
                //                           size: 16,
                //                         ),
                //                       ),
                //                       onTap: () {
                //                         Helper.showAdd(
                //                             context,
                //                             treeModel.data!.sId,
                //                             treeModel.data!.spouseId == null
                //                                 ? true
                //                                 : false,
                //                             treeModel.data!.spouseId == null
                //                                 ? false
                //                                 : true,
                //                             treeModel.data!.fatherId == null
                //                                 ? true
                //                                 : false);
                //                       },
                //                     )),
                //             Positioned(
                //                 left: 45,
                //                 child: treeModel.data!.gender == "Male"
                //                     ? const Icon(
                //                         Icons.male,
                //                         size: 16,
                //                       )
                //                     : const Icon(
                //                         Icons.female,
                //                         size: 16,
                //                       ))
                //           ],
                //         ),
                //       ),
                //       onTap: () {
                //         // treeModel.data!.amI == true
                //         //     ? Helper.showAdd(
                //         //         context,
                //         //         treeModel.data!.sId.toString(),
                //         //         treeModel.data!.spouseId == null ? true : false,
                //         //         true,
                //         //         true)
                //         //     :

                //         context
                //             .read<MainBloc>()
                //             .add(GetUser(userID: treeModel.data!.sId));
                //       },
                //     ),
                //     SizedBox(
                //       height: 30,
                //       width: MediaQuery.of(context).size.width / 3,
                //       child: ClipRRect(
                //         borderRadius: const BorderRadius.only(
                //             bottomLeft: Radius.circular(18),
                //             bottomRight: Radius.circular(18)),
                //         child: MaterialButton(
                //             color: Colors.green[300],
                //             child: const Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   "Profile",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 15),
                //                 ),
                //                 // treeModel.data!.spouseId != null
                //                 //     ? const CircleAvatar(
                //                 //         radius: 10,
                //                 //         backgroundImage: AssetImage(
                //                 //             "assets/wedding-rings.png"))
                //                 //     : const SizedBox.shrink()
                //               ],
                //             ),
                //             onPressed: () {
                //               Helper.push(
                //                   context,
                //                   ProfileDetailed(
                //                     userId: treeModel.data!.sId.toString(),
                //                   ));
                //             }),
                //       ),
                //     )
                //   ],
                // ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 110.5),
              Column(
                children: [
                  Image.asset("assets/images/parents.png", height: 60),
                  const SizedBox(
                    height: 5,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 110.5),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // treeModel.data!.spouseId!.amI == true
                      //     ? Helper.showAdd(
                      //         context,
                      //         treeModel.data!.sId.toString(),
                      //         treeModel.data!.spouseId == null ? true : false,
                      //         true,
                      //         true)
                      //     :

                      context
                          .read<MainBloc>()
                          .add(GetUser(userID: treeModel.data!.spouseId!.sId));
                    },
                    child: Helper.myprofilecard(
                        context,
                        "assets/images/profiles/profile2.png",
                        treeModel.data!.spouseId!.sId,
                        treeModel.data!.spouseId!.name!,
                        treeModel.data!.spouseId!.gender,
                        treeModel.data!.spouseId!.maritalStatus == "Single"
                            ? true
                            : false,
                        treeModel.data!.spouseId!.amI,
                        treeModel.data!.spouseId!.isRoot,
                        "Spouse",
                        treeModel.data!.spouseId!.mainFamilyId != null
                            ? true
                            : false,
                        "Family Name",
                        false),
                    // Container(
                    //   padding: const EdgeInsets.all(14.0),
                    //   width: MediaQuery.of(context).size.width / 3,
                    //   decoration: BoxDecoration(
                    //       color: treeModel.data!.spouseId!.amI == true
                    //           ? Colors.blue
                    //           : Colors.blue[200],
                    //       borderRadius: const BorderRadius.only(
                    //           topLeft: Radius.circular(18),
                    //           topRight: Radius.circular(18)),
                    //       boxShadow: [
                    //         BoxShadow(color: Colors.grey.withOpacity(0.5)),
                    //       ]),
                    //   child: Stack(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           const CircleAvatar(
                    //             backgroundImage:
                    //                 AssetImage("assets/familyilogo.jpg"),
                    //             backgroundColor: Colors.grey,
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //             child: Text(
                    //               treeModel.data!.spouseId!.name!,
                    //               style: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       treeModel.data!.spouseId!.amI != true ||
                    //               treeModel.data!.spouseId!.isRoot != true
                    //           ? const SizedBox.shrink()
                    //           : Positioned(
                    //               left: 70,
                    //               child: InkWell(
                    //                 child: const CircleAvatar(
                    //                   backgroundColor: Colors.green,
                    //                   radius: 11,
                    //                   child: Icon(
                    //                     Icons.add,
                    //                     size: 16,
                    //                   ),
                    //                 ),
                    //                 onTap: () {
                    //                   Helper.showAdd(
                    //                       context,
                    //                       treeModel.data!.spouseId!.sId,
                    //                       treeModel.data!.spouseId == null
                    //                           ? true
                    //                           : false,
                    //                       treeModel.data!.spouseId == null
                    //                           ? false
                    //                           : true,
                    //                       treeModel.data!.fatherId == null
                    //                           ? true
                    //                           : false);
                    //                 },
                    //               )),
                    //       Positioned(
                    //           left: 45,
                    //           child: treeModel.data!.spouseId!.gender == "Male"
                    //               ? const Icon(
                    //                   Icons.male,
                    //                   size: 16,
                    //                 )
                    //               : const Icon(
                    //                   Icons.female,
                    //                   size: 16,
                    //                 ))
                    //     ],
                    //   ),

                    //   // Text(
                    //   //   treeModel.data!.spouseId!.name!,
                    //   //   overflow: TextOverflow.ellipsis,
                    //   //   style: const TextStyle(
                    //   //       color: Colors.white,
                    //   //       fontWeight: FontWeight.bold,
                    //   //       fontSize: 16),
                    //   // ),
                    // ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  //   width: MediaQuery.of(context).size.width / 3,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(
                  //         bottomLeft: Radius.circular(18),
                  //         bottomRight: Radius.circular(18)),
                  //     child: MaterialButton(
                  //         color: Colors.green[300],
                  //         child: const Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Profile",
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 15),
                  //             ),
                  //             // treeModel.data!.spouseId != null
                  //             //     ? const CircleAvatar(
                  //             //         radius: 10,
                  //             //         backgroundImage: AssetImage(
                  //             //             "assets/wedding-rings.png"))
                  //             //     : const SizedBox.shrink()
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Helper.push(
                  //               context,
                  //               ProfileDetailed(
                  //                 userId:
                  //                     treeModel.data!.spouseId!.sId.toString(),
                  //               ));
                  //           // print(treeModel.data!.spouseId!.sId.toString());
                  //         }),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 0),
        OuterContainer(
          child: Column(
            children: [
              Image.asset("assets/images/childrens.png", height: 70),
              SizedBox(
                height: treeModel.data!.childrens!.length < 3
                    ? 150
                    : treeModel.data!.childrens!.length < 5
                        ? 300
                        : treeModel.data!.childrens!.length < 7
                            ? 450
                            : 800,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            childAspectRatio: 3 / 2.7,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 28),
                    itemCount: treeModel.data!.childrens!.length,
                    itemBuilder: (BuildContext ctx, indexOne) {
                      return InkWell(
                        onTap: () => treeModel
                                    .data!.childrens![indexOne].maritalStatus !=
                                "Single"
                            ? context.read<MainBloc>().add(GetUser(
                                userID:
                                    treeModel.data!.childrens![indexOne].sId))
                            : Helper.showToast(
                                msg: treeModel
                                    .data!.childrens![indexOne].maritalStatus),
                        child: Column(
                          children: [
                            Flexible(
                              child: Helper.myprofilecard(
                                  context,
                                  "assets/images/profiles/profile3.png",
                                  treeModel.data!.childrens![indexOne].sId,
                                  treeModel.data!.childrens![indexOne].name!,
                                  treeModel.data!.childrens![indexOne].gender,
                                  treeModel.data!.childrens![indexOne]
                                              .maritalStatus ==
                                          "Single"
                                      ? true
                                      : false,
                                  treeModel.data!.childrens![indexOne].amI,
                                  treeModel.data!.childrens![indexOne].isRoot,
                                  treeModel.data!.childrens![indexOne]
                                              .gender ==
                                          "Male"
                                      ? "Son"
                                      : "Daughter",
                                  treeModel.data!.childrens![indexOne]
                                              .fatherId !=
                                          null
                                      ? true
                                      : false,
                                  treeModel.data!.mainFamilyId!.familyName,
                                  true),
                            )
                            // Container(
                            //   width: MediaQuery.of(context).size.width / 3,
                            //   padding: const EdgeInsets.all(14.0),
                            //   decoration: BoxDecoration(
                            //     color:
                            //         treeModel.data!.childrens![indexOne].amI ==
                            //                 true
                            //             ? Colors.blue
                            //             : Colors.blue[200],
                            //     borderRadius: const BorderRadius.only(
                            //         topLeft: Radius.circular(18),
                            //         topRight: Radius.circular(18)),
                            //     // boxShadow: [
                            //     //   BoxShadow(color: Colors.grey.withOpacity(0.5)),
                            //     // ]
                            //   ),
                            //   child: Stack(
                            //     children: [
                            //       Column(
                            //         children: [
                            //           const CircleAvatar(
                            //             backgroundImage: AssetImage(
                            //                 "assets/familyilogo.jpg"),
                            //             backgroundColor: Colors.grey,
                            //           ),
                            //           SizedBox(
                            //             width: 88,
                            //             height: 20,
                            //             child: Text(
                            //               treeModel
                            //                   .data!.childrens![indexOne].name!,
                            //               style: const TextStyle(
                            //                   overflow: TextOverflow.clip,
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       treeModel.data!.childrens![indexOne].amI !=
                            //                   true ||
                            //               treeModel.data!.childrens![indexOne]
                            //                       .isRoot !=
                            //                   true
                            //           ? const SizedBox.shrink()
                            //           : Positioned(
                            //               left: 70,
                            //               child: InkWell(
                            //                 child: const CircleAvatar(
                            //                   backgroundColor: Colors.green,
                            //                   radius: 11,
                            //                   child: Icon(
                            //                     Icons.add,
                            //                     size: 16,
                            //                   ),
                            //                 ),
                            //                 onTap: () {
                            //                   Helper.showAdd(
                            //                     context,
                            //                     treeModel.data!
                            //                         .childrens![indexOne].sId,
                            //                     treeModel
                            //                                 .data!
                            //                                 .childrens![
                            //                                     indexOne]
                            //                                 .maritalStatus ==
                            //                             "Single"
                            //                         ? true
                            //                         : false,
                            //                     treeModel
                            //                                 .data!
                            //                                 .childrens![
                            //                                     indexOne]
                            //                                 .maritalStatus !=
                            //                             "Single"
                            //                         ? true
                            //                         : false,
                            //                     treeModel
                            //                                 .data!
                            //                                 .childrens![
                            //                                     indexOne]
                            //                                 .fatherId ==
                            //                             null
                            //                         ? true
                            //                         : false,
                            //                   );
                            //                 },
                            //               )),
                            //       Positioned(
                            //           left: 55,
                            //           child: treeModel.data!.gender == "Male"
                            //               ? const Icon(
                            //                   Icons.male,
                            //                   size: 16,
                            //                 )
                            //               : const Icon(
                            //                   Icons.female,
                            //                   size: 16,
                            //                 ))
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 30,
                            //   width: MediaQuery.of(context).size.width / 3,
                            //   child: ClipRRect(
                            //     borderRadius: const BorderRadius.only(
                            //         bottomLeft: Radius.circular(18),
                            //         bottomRight: Radius.circular(18)),
                            //     child: MaterialButton(
                            //         color: Colors.green[300],
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             const Text(
                            //               "Profile",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 15),
                            //             ),
                            //             treeModel.data!.childrens![indexOne]
                            //                         .maritalStatus ==
                            //                     "Married"
                            //                 ? const CircleAvatar(
                            //                     radius: 10,
                            //                     backgroundImage: AssetImage(
                            //                         "assets/wedding-rings.png"))
                            //                 : const SizedBox.shrink()
                            //           ],
                            //         ),
                            //         onPressed: () {
                            //           Helper.push(
                            //               context,
                            //               ProfileDetailed(
                            //                 userId: treeModel
                            //                     .data!.childrens![indexOne].sId
                            //                     .toString(),
                            //               ));
                            //           // print(
                            //           //     treeModel.data!.spouseId!.sId.toString());
                            //         }),
                            //   ),
                            // )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),

          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     mainAxisSize: MainAxisSize.max,
          //     children:

          //     List.generate(
          //       treeModel.data!.childrens!.length,
          //       (indexOne) => InkWell(
          //         onTap: () => treeModel
          //                     .data!.childrens![indexOne].maritalStatus !=
          //                 "Single"
          //             ? context.read<MainBloc>().add(GetUser(
          //                 userID: treeModel.data!.childrens![indexOne].sId))
          //             : Helper.showToast(
          //                 msg: treeModel
          //                     .data!.childrens![indexOne].maritalStatus),
          //         child: Column(
          //           children: [
          //             Container(
          //               width: MediaQuery.of(context).size.width / 3,
          //               padding: const EdgeInsets.all(14.0),
          //               decoration: BoxDecoration(
          //                 color: treeModel.data!.amI == true
          //                     ? Colors.blue[200]
          //                     : Colors.blue[200],
          //                 borderRadius: const BorderRadius.only(
          //                     topLeft: Radius.circular(18),
          //                     topRight: Radius.circular(18)),
          //                 // boxShadow: [
          //                 //   BoxShadow(color: Colors.grey.withOpacity(0.5)),
          //                 // ]
          //               ),
          //               child: Stack(
          //                 children: [
          //                   Column(
          //                     children: [
          //                       const CircleAvatar(
          //                         backgroundImage:
          //                             AssetImage("assets/familyilogo.jpg"),
          //                         backgroundColor: Colors.grey,
          //                       ),
          //                       Text(
          //                         treeModel.data!.childrens![indexOne].name!,
          //                         style: const TextStyle(
          //                             color: Colors.white,
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 15),
          //                       ),
          //                     ],
          //                   ),
          //                   Positioned(
          //                       left: 49,
          //                       child: treeModel.data!.childrens![indexOne]
          //                                   .gender! ==
          //                               "Male"
          //                           ? const Icon(
          //                               Icons.male,
          //                               size: 16,
          //                             )
          //                           : const Icon(
          //                               Icons.female,
          //                               size: 16,
          //                             ))
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: 30,
          //               width: MediaQuery.of(context).size.width / 3,
          //               child: ClipRRect(
          //                 borderRadius: const BorderRadius.only(
          //                     bottomLeft: Radius.circular(18),
          //                     bottomRight: Radius.circular(18)),
          //                 child: MaterialButton(
          //                     color: Colors.green[300],
          //                     child: const Text(
          //                       "Profile",
          //                       style: TextStyle(
          //                           color: Colors.white,
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: 15),
          //                     ),
          //                     onPressed: () {
          //                       Helper.push(
          //                           context,
          //                           ProfileDetailed(
          //                             userId: treeModel
          //                                 .data!.childrens![indexOne].sId
          //                                 .toString(),
          //                           ));
          //                       print(treeModel.data!.spouseId!.sId.toString());
          //                     }),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),

          //     )),
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
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      context
                          .read<MainBloc>()
                          .add(GetUser(userID: treeModel.data!.sId));
                    },
                    child: Helper.myprofilecard(
                        context,
                        "assets/images/profiles/profile8.png",
                        treeModel.data!.sId,
                        treeModel.data!.name!,
                        treeModel.data!.gender,
                        treeModel.data!.maritalStatus == "Single"
                            ? true
                            : false,
                        treeModel.data!.amI,
                        treeModel.data!.isRoot,
                        "You",
                        treeModel.data!.fatherId != null ? true : false,
                        treeModel.data!.mainFamilyId!.familyName,
                        false),
                    //  Container(
                    //   width: MediaQuery.of(context).size.width / 3,
                    //   padding: const EdgeInsets.all(14.0),
                    //   decoration: BoxDecoration(
                    //     color: treeModel.data!.amI == true
                    //         ? Colors.blue
                    //         : Colors.blue[100],
                    //     borderRadius: const BorderRadius.only(
                    //         topLeft: Radius.circular(18),
                    //         topRight: Radius.circular(18)),
                    //   ),
                    //   child: Stack(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           const CircleAvatar(
                    //             backgroundImage:
                    //                 AssetImage("assets/familyilogo.jpg"),
                    //             backgroundColor: Colors.grey,
                    //           ),
                    //           SizedBox(
                    //             width: 88,
                    //             height: 20,
                    //             child: Text(
                    //               treeModel.data!.name!,
                    //               style: const TextStyle(
                    //                   overflow: TextOverflow.clip,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       treeModel.data!.amI != true ||
                    //               treeModel.data!.isRoot != true
                    //           ? const SizedBox.shrink()
                    //           : Positioned(
                    //               left: 70,
                    //               child: InkWell(
                    //                 child: const CircleAvatar(
                    //                   backgroundColor: Colors.green,
                    //                   radius: 11,
                    //                   child: Icon(
                    //                     Icons.add,
                    //                     size: 16,
                    //                   ),
                    //                 ),
                    //                 onTap: () {
                    //                   Helper.showAdd(
                    //                       context,
                    //                       treeModel.data!.sId,
                    //                       treeModel.data!.spouseId != null
                    //                           ? false
                    //                           : true,
                    //                       treeModel.data!.spouseId == null
                    //                           ? false
                    //                           : true,
                    //                       treeModel.data!.fatherId == null
                    //                           ? true
                    //                           : false);
                    //                 },
                    //               )),
                    //       Positioned(
                    //           left: 45,
                    //           child: treeModel.data!.gender == "Male"
                    //               ? const Icon(
                    //                   Icons.male,
                    //                   size: 16,
                    //                 )
                    //               : const Icon(
                    //                   Icons.female,
                    //                   size: 16,
                    //                 ))
                    //     ],
                    //   ),

                    //   // Text(
                    //   //   treeModel.data!.name!,
                    //   //   style: const TextStyle(
                    //   //       color: Colors.white,
                    //   //       fontWeight: FontWeight.bold,
                    //   //       fontSize: 16),
                    //   // ),
                    // ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  //   width: MediaQuery.of(context).size.width / 3,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(
                  //         bottomLeft: Radius.circular(18),
                  //         bottomRight: Radius.circular(18)),
                  //     child: MaterialButton(
                  //         color: Colors.green[300],
                  //         child: const Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Profile",
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 15),
                  //             ),
                  //             // treeModel.data!.maritalStatus == "Married"
                  //             //     ? const CircleAvatar(
                  //             //         radius: 10,
                  //             //         backgroundImage: AssetImage(
                  //             //             "assets/wedding-rings.png"))
                  //             //     : const SizedBox.shrink()
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Helper.push(
                  //               context,
                  //               ProfileDetailed(
                  //                 userId: treeModel.data!.sId.toString(),
                  //               ));
                  //           // print(treeModel.data!.spouseId!.sId.toString());
                  //         }),
                  //   ),
                  // )
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 110.5),
              Column(
                children: [
                  Image.asset("assets/images/parents.png", height: 60),
                  const SizedBox(
                    height: 5,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 110.5),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      context
                          .read<MainBloc>()
                          .add(GetUser(userID: treeModel.data!.spouseId!.sId));
                    },
                    child: Helper.myprofilecard(
                        context,
                        "assets/images/profiles/profile2.png",
                        treeModel.data!.spouseId!.sId,
                        treeModel.data!.spouseId!.name!,
                        treeModel.data!.spouseId!.gender,
                        treeModel.data!.spouseId!.maritalStatus == "Single"
                            ? true
                            : false,
                        treeModel.data!.spouseId!.amI,
                        treeModel.data!.spouseId!.isRoot,
                        "Spouse",
                        treeModel.data!.spouseId!.mainFamilyId != null
                            ? true
                            : false,
                        "Family Name",
                        false),
                    // Container(
                    //   width: MediaQuery.of(context).size.width / 3,
                    //   padding: const EdgeInsets.all(14.0),
                    //   // width: MediaQuery.of(context).size.width / 2.5,
                    //   decoration: BoxDecoration(
                    //     color: treeModel.data!.spouseId!.amI == true
                    //         ? Colors.blue
                    //         : Colors.blue[100],
                    //     borderRadius: const BorderRadius.only(
                    //         topLeft: Radius.circular(18),
                    //         topRight: Radius.circular(18)),
                    //   ),
                    //   child: Stack(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           const CircleAvatar(
                    //             backgroundImage:
                    //                 AssetImage("assets/familyilogo.jpg"),
                    //             backgroundColor: Colors.grey,
                    //           ),
                    //           SizedBox(
                    //             width: 88,
                    //             height: 20,
                    //             child: Text(
                    //               treeModel.data!.spouseId!.name!,
                    //               style: const TextStyle(
                    //                   overflow: TextOverflow.clip,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       treeModel.data!.spouseId!.amI != true ||
                    //               treeModel.data!.spouseId!.isRoot != true
                    //           ? const SizedBox.shrink()
                    //           : Positioned(
                    //               left: 70,
                    //               child: InkWell(
                    //                 child: const CircleAvatar(
                    //                   backgroundColor: Colors.green,
                    //                   radius: 11,
                    //                   child: Icon(
                    //                     Icons.add,
                    //                     size: 16,
                    //                   ),
                    //                 ),
                    //                 onTap: () {
                    //                   Helper.showAdd(
                    //                       context,
                    //                       treeModel.data!.spouseId!.sId,
                    //                       treeModel.data!.spouseId != null
                    //                           ? false
                    //                           : true,
                    //                       treeModel.data!.spouseId == null
                    //                           ? false
                    //                           : true,
                    //                       treeModel.data!.spouseId == null
                    //                           ? true
                    //                           : false);
                    //                 },
                    //               )),
                    //       Positioned(
                    //           left: 45,
                    //           child: treeModel.data!.spouseId!.gender == "Male"
                    //               ? const Icon(
                    //                   Icons.male,
                    //                   size: 16,
                    //                 )
                    //               : const Icon(
                    //                   Icons.female,
                    //                   size: 16,
                    //                 ))
                    //     ],
                    //   ),

                    //   //  Text(
                    //   //   treeModel.data!.spouseId!.name!,
                    //   //   overflow: TextOverflow.ellipsis,
                    //   //   style: const TextStyle(
                    //   //       color: Colors.white,
                    //   //       fontWeight: FontWeight.bold,
                    //   //       fontSize: 16),
                    //   // ),
                    // ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  //   width: MediaQuery.of(context).size.width / 3,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(
                  //         bottomLeft: Radius.circular(18),
                  //         bottomRight: Radius.circular(18)),
                  //     child: MaterialButton(
                  //         color: Colors.green[300],
                  //         child: const Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Profile",
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 15),
                  //             ),
                  //             // treeModel.data!.spouseId != null
                  //             //     ? const CircleAvatar(
                  //             //         radius: 10,
                  //             //         backgroundImage: AssetImage(
                  //             //             "assets/wedding-rings.png"))
                  //             //     : const SizedBox.shrink()
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Helper.push(
                  //               context,
                  //               ProfileDetailed(
                  //                 userId:
                  //                     treeModel.data!.spouseId!.sId.toString(),
                  //               ));
                  //           // print(treeModel.data!.spouseId!.sId.toString());
                  //         }),
                  //   ),
                  // )
                ],
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
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(100.0),
      minScale: 0.01,
      child: Column(
        children: [
          OuterContainer(
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 108.0),
                    //         child: Image.asset("assets/images/grandparents.png",
                    //             height: 80),
                    //       )
                    //     ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () => context.read<MainBloc>().add(
                                    GetUser(
                                        userID: treeModel.data!.fatherId!.sId)),
                                child: Helper.myprofilecard(
                                    context,
                                    "assets/images/profiles/profile1.png",
                                    treeModel.data!.fatherId!.sId,
                                    treeModel.data!.fatherId!.name!,
                                    treeModel.data!.fatherId!.gender,
                                    treeModel.data!.fatherId!.maritalStatus ==
                                            "Single"
                                        ? true
                                        : false,
                                    treeModel.data!.fatherId!.amI,
                                    treeModel.data!.fatherId!.isRoot,
                                    "Father",
                                    treeModel.data!.fatherId!.familyId != null
                                        ? true
                                        : false,
                                    treeModel.data!.mainFamilyId!.familyName,
                                    false),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       color: Colors.grey[200],
                                //       borderRadius: const BorderRadius.all(
                                //           Radius.circular(8.0))),
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     "${treeModel.data!.fatherId!.name}",
                                //     style: TextStyle(
                                //         color:
                                //             treeModel.data!.fatherId!.amI == true
                                //                 ? Colors.green
                                //                 : Colors.black,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      110.5),
                              Column(
                                children: [
                                  Image.asset("assets/images/grandparents.png",
                                      height: 60),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ],
                              ),

                              SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      110.5),
                              // Helper.hDivider(
                              //     width: MediaQuery.of(context).size.width / 9),
                              InkWell(
                                onTap: () => context.read<MainBloc>().add(
                                    GetUser(
                                        userID: treeModel.data!.fatherId!.sId)),
                                child: Helper.myprofilecard(
                                    context,
                                    "assets/images/profiles/profile7.png",
                                    treeModel.data!.motherId!.sId,
                                    treeModel.data!.motherId!.name!,
                                    treeModel.data!.motherId!.gender,
                                    treeModel.data!.motherId!.maritalStatus ==
                                            "Single"
                                        ? true
                                        : false,
                                    treeModel.data!.motherId!.amI,
                                    treeModel.data!.motherId!.isRoot,
                                    "Mother",
                                    treeModel.data!.motherId!.familyId != null
                                        ? true
                                        : false,
                                    "Family Name",
                                    false),

                                //  Container(
                                //   decoration: BoxDecoration(
                                //       color: Colors.grey[200],
                                //       borderRadius: const BorderRadius.all(
                                //           Radius.circular(8.0))),
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     "${treeModel.data!.motherId!.name}",
                                //     style: TextStyle(
                                //         color:
                                //             treeModel.data!.motherId!.amI == true
                                //                 ? Colors.green
                                //                 : Colors.black,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ),
                            ],
                          ),

                          // Helper.allowWidth(55),
                          // treeModel.data!.spouseId!.fatherId == null
                          //     ? const SizedBox.shrink()
                          //     : Column(
                          //         children: [
                          //           Row(
                          //             children: [
                          //               InkWell(
                          //                 onTap: () => context.read<MainBloc>().add(
                          //                     GetUser(
                          //                         userID: treeModel.data!.spouseId!
                          //                             .fatherId!.sId)),
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                       color: Colors.grey[200],
                          //                       borderRadius:
                          //                           const BorderRadius.all(
                          //                               Radius.circular(8.0))),
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     "${treeModel.data!.spouseId!.fatherId!.name}",
                          //                     style: TextStyle(
                          //                         color: treeModel.data!.spouseId!
                          //                                     .fatherId!.amI ==
                          //                                 true
                          //                             ? Colors.green
                          //                             : Colors.black,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 ),
                          //               ),
                          //               Helper.allowWidth(10),
                          //               InkWell(
                          //                 onTap: () => context.read<MainBloc>().add(
                          //                     GetUser(
                          //                         userID: treeModel.data!.spouseId!
                          //                             .fatherId!.sId)),
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                       color: Colors.grey[200],
                          //                       borderRadius:
                          //                           const BorderRadius.all(
                          //                               Radius.circular(8.0))),
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     "${treeModel.data!.spouseId!.motherId!.name}",
                          //                     style: TextStyle(
                          //                         color: treeModel.data!.spouseId!
                          //                                     .motherId!.amI ==
                          //                                 true
                          //                             ? Colors.green
                          //                             : Colors.black,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 45.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           Helper.allowHeight(5),
                    //           Helper.vDivider(height: 20.0),
                    //           Helper.allowHeight(5),
                    //         ],
                    //       ),
                    //     ),

                    //   ],
                    // ),
                    Helper.allowHeight(25),
                    // Helper.vDivider(height: 20.0),
                    // Helper.allowHeight(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () => {
                            context
                                .read<MainBloc>()
                                .add(GetUser(userID: treeModel.data!.sId))
                          },
                          child: Helper.myprofilecard(
                              context,
                              "assets/images/profiles/profile8.png",
                              treeModel.data!.sId,
                              treeModel.data!.name!,
                              treeModel.data!.gender,
                              treeModel.data!.maritalStatus == "Single"
                                  ? true
                                  : false,
                              treeModel.data!.amI,
                              treeModel.data!.isRoot,
                              "You",
                              treeModel.data!.fatherId != null ? true : false,
                              treeModel.data!.mainFamilyId!.familyName,
                              false),
                          // Column(
                          //   children: [
                          //     Container(
                          //       width: MediaQuery.of(context).size.width / 3,
                          //       padding: const EdgeInsets.all(14.0),
                          //       decoration: BoxDecoration(
                          //           color: treeModel.data!.amI == true
                          //               ? Colors.blue
                          //               : Colors.blue[200],
                          //           borderRadius: const BorderRadius.only(
                          //               topLeft: Radius.circular(18),
                          //               topRight: Radius.circular(18)),
                          //           boxShadow: [
                          //             BoxShadow(
                          //                 color: Colors.grey.withOpacity(0.5)),
                          //           ]),
                          //       child: Stack(
                          //         children: [
                          //           Column(
                          //             children: [
                          //               const CircleAvatar(
                          //                 backgroundImage: AssetImage(
                          //                     "assets/familyilogo.jpg"),
                          //                 backgroundColor: Colors.grey,
                          //               ),
                          //               Text(
                          //                 treeModel.data!.name!,
                          //                 style: const TextStyle(
                          //                     color: Colors.white,
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 15),
                          //               ),
                          //             ],
                          //           ),
                          //           treeModel.data!.amI != true ||
                          //                   treeModel.data!.isRoot != true
                          //               ? const SizedBox.shrink()
                          //               : Positioned(
                          //                   left: 70,
                          //                   child: InkWell(
                          //                     child: const CircleAvatar(
                          //                       backgroundColor: Colors.green,
                          //                       radius: 11,
                          //                       child: Icon(
                          //                         Icons.add,
                          //                         size: 16,
                          //                       ),
                          //                     ),
                          //                     onTap: () {
                          //                       Helper.showAdd(
                          //                           context,
                          //                           treeModel.data!.sId,
                          //                           treeModel.data!.spouseId !=
                          //                                   null
                          //                               ? false
                          //                               : true,
                          //                           treeModel.data!.spouseId ==
                          //                                   null
                          //                               ? false
                          //                               : true,
                          //                           treeModel.data!.familyId ==
                          //                                   null
                          //                               ? true
                          //                               : false);
                          //                     },
                          //                   )),
                          //           Positioned(
                          //               left: 30,
                          //               child: treeModel.data!.gender == "Male"
                          //                   ? const Icon(
                          //                       Icons.male,
                          //                       size: 16,
                          //                     )
                          //                   : const Icon(
                          //                       Icons.female,
                          //                       size: 16,
                          //                     ))
                          //         ],
                          //       ),

                          //       //  Text(
                          //       //   treeModel.data!.name!,
                          //       //   style: const TextStyle(
                          //       //       color: Colors.white,
                          //       //       fontWeight: FontWeight.bold,
                          //       //       fontSize: 16),
                          //       // ),
                          //     ),
                          //     SizedBox(
                          //       height: 30,
                          //       width: MediaQuery.of(context).size.width / 3,
                          //       child: ClipRRect(
                          //         borderRadius: const BorderRadius.only(
                          //             bottomLeft: Radius.circular(18),
                          //             bottomRight: Radius.circular(18)),
                          //         child: MaterialButton(
                          //             color: Colors.green[300],
                          //             child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Text(
                          //                   "Profile",
                          //                   style: TextStyle(
                          //                       color: Colors.white,
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 15),
                          //                 ),
                          //                 // treeModel.data!.spouseId != null
                          //                 //     ? const CircleAvatar(
                          //                 //         radius: 10,
                          //                 //         backgroundImage: AssetImage(
                          //                 //             "assets/wedding-rings.png"))
                          //                 //     : const SizedBox.shrink()
                          //               ],
                          //             ),
                          //             onPressed: () {
                          //               Helper.push(
                          //                   context,
                          //                   ProfileDetailed(
                          //                     userId:
                          //                         treeModel.data!.sId.toString(),
                          //                   ));
                          //               // print(treeModel.data!.spouseId!.sId
                          //               //     .toString());
                          //             }),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 110.5),
                        Column(
                          children: [
                            Image.asset("assets/images/parents.png",
                                height: 60),
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),

                        SizedBox(
                            width: MediaQuery.of(context).size.width / 110.5),

                        // Helper.hDivider(
                        //     width: MediaQuery.of(context).size.width / 9),
                        InkWell(
                          onTap: () => {
                            context.read<MainBloc>().add(
                                GetUser(userID: treeModel.data!.spouseId!.sId))
                          },
                          child: Helper.myprofilecard(
                              context,
                              "assets/images/profiles/profile2.png",
                              treeModel.data!.spouseId!.sId,
                              treeModel.data!.spouseId!.name!,
                              treeModel.data!.spouseId!.gender,
                              treeModel.data!.spouseId!.maritalStatus ==
                                      "Single"
                                  ? true
                                  : false,
                              treeModel.data!.spouseId!.amI,
                              treeModel.data!.spouseId!.isRoot,
                              "Spouse",
                              treeModel.data!.spouseId!.mainFamilyId != null
                                  ? true
                                  : false,
                              "Family Name",
                              false),
                          // Flexible(
                          //   child: Column(
                          //     children: [

                          //       // Container(
                          //       //   width: MediaQuery.of(context).size.width / 3,
                          //       //   padding: const EdgeInsets.all(14.0),
                          //       //   decoration: BoxDecoration(
                          //       //       color: treeModel.data!.spouseId!.amI == true
                          //       //           ? Colors.blue
                          //       //           : Colors.blue[200],
                          //       //       borderRadius: const BorderRadius.only(
                          //       //           topLeft: Radius.circular(18),
                          //       //           topRight: Radius.circular(18)),
                          //       //       boxShadow: [
                          //       //         BoxShadow(
                          //       //             color: Colors.grey.withOpacity(0.5)),
                          //       //       ]),
                          //       //   child: Stack(
                          //       //     children: [
                          //       //       Column(
                          //       //         children: [
                          //       //           const CircleAvatar(
                          //       //             backgroundImage: AssetImage(
                          //       //                 "assets/familyilogo.jpg"),
                          //       //             backgroundColor: Colors.grey,
                          //       //           ),
                          //       //           SizedBox(
                          //       //             height: 20,
                          //       //             child: Text(
                          //       //               treeModel.data!.spouseId!.name!,
                          //       //               style: const TextStyle(
                          //       //                   color: Colors.white,
                          //       //                   fontWeight: FontWeight.bold,
                          //       //                   fontSize: 15),
                          //       //             ),
                          //       //           ),
                          //       //         ],
                          //       //       ),
                          //       //       treeModel.data!.spouseId!.amI != true ||
                          //       //               treeModel.data!.spouseId!.isRoot !=
                          //       //                   true
                          //       //           ? const SizedBox.shrink()
                          //       //           : Positioned(
                          //       //               left: 70,
                          //       //               child: InkWell(
                          //       //                 child: const CircleAvatar(
                          //       //                   backgroundColor: Colors.green,
                          //       //                   radius: 11,
                          //       //                   child: Icon(
                          //       //                     Icons.add,
                          //       //                     size: 16,
                          //       //                   ),
                          //       //                 ),
                          //       //                 onTap: () {
                          //       //                   Helper.showAdd(
                          //       //                       context,
                          //       //                       treeModel.data!.spouseId!.sId,
                          //       //                       treeModel.data!.spouseId !=
                          //       //                               null
                          //       //                           ? false
                          //       //                           : true,
                          //       //                       treeModel.data!.spouseId ==
                          //       //                               null
                          //       //                           ? false
                          //       //                           : true,
                          //       //                       treeModel.data!.spouseId!
                          //       //                                   .mainFamilyId ==
                          //       //                               null
                          //       //                           ? true
                          //       //                           : false);
                          //       //                 },
                          //       //               )),
                          //       //       Positioned(
                          //       //           left: 30,
                          //       //           child: treeModel.data!.spouseId!.gender ==
                          //       //                   "Male"
                          //       //               ? const Icon(
                          //       //                   Icons.male,
                          //       //                   size: 16,
                          //       //                 )
                          //       //               : const Icon(
                          //       //                   Icons.female,
                          //       //                   size: 16,
                          //       //                 ))
                          //       //     ],
                          //       //   ),
                          //       //   //  Text(
                          //       //   //   treeModel.data!.spouseId!.name!,
                          //       //   //   style: const TextStyle(
                          //       //   //       color: Colors.white,
                          //       //   //       fontWeight: FontWeight.bold,
                          //       //   //       fontSize: 16),
                          //       //   // ),
                          //       // ),

                          //       // SizedBox(
                          //       //   height: 30,
                          //       //   width: MediaQuery.of(context).size.width / 3,
                          //       //   child: ClipRRect(
                          //       //     borderRadius: const BorderRadius.only(
                          //       //         bottomLeft: Radius.circular(18),
                          //       //         bottomRight: Radius.circular(18)),
                          //       //     child: MaterialButton(
                          //       //         color: Colors.green[300],
                          //       //         child: const Row(
                          //       //           mainAxisAlignment:
                          //       //               MainAxisAlignment.spaceBetween,
                          //       //           children: [
                          //       //             Text(
                          //       //               "Profile",
                          //       //               style: TextStyle(
                          //       //                   color: Colors.white,
                          //       //                   fontWeight: FontWeight.bold,
                          //       //                   fontSize: 15),
                          //       //             ),
                          //       //             // treeModel.data!.spouseId != null
                          //       //             //     ? const CircleAvatar(
                          //       //             //         radius: 10,
                          //       //             //         backgroundImage: AssetImage(
                          //       //             //             "assets/wedding-rings.png"))
                          //       //             //     : const SizedBox.shrink()
                          //       //           ],
                          //       //         ),
                          //       //         onPressed: () {
                          //       //           Helper.push(
                          //       //               context,
                          //       //               ProfileDetailed(
                          //       //                 userId: treeModel
                          //       //                     .data!.spouseId!.sId
                          //       //                     .toString(),
                          //       //               ));
                          //       //           // print(treeModel.data!.spouseId!.sId
                          //       //           //     .toString());
                          //       //         }),
                          //       //   ),
                          //       // )
                          //     ],
                          //   ),
                          // ),
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
          const SizedBox(height: 0),
          // Helper.vDivider(height: 60.0),
          OuterContainer(
              child: Column(
            children: [
              Image.asset("assets/images/childrens.png", height: 70),
              SizedBox(
                  height: treeModel.data!.childrens!.length < 3
                      ? 150
                      : treeModel.data!.childrens!.length < 5
                          ? 300
                          : treeModel.data!.childrens!.length < 7
                              ? 450
                              : 800,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              childAspectRatio: 3 / 2.7,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 28),
                      itemCount: treeModel.data!.childrens!.length,
                      itemBuilder: (BuildContext ctx, indextwo) {
                        return InkWell(
                          onTap: () => treeModel.data!.childrens![indextwo]
                                      .maritalStatus !=
                                  "Single"
                              ? context.read<MainBloc>().add(GetUser(
                                  userID:
                                      treeModel.data!.childrens![indextwo].sId))
                              : Helper.showToast(
                                  msg: treeModel.data!.childrens![indextwo]
                                      .maritalStatus),
                          child: Column(
                            children: [
                              Flexible(
                                child: Helper.myprofilecard(
                                    context,
                                    "assets/images/profiles/profile3.png",
                                    treeModel.data!.childrens![indextwo].sId,
                                    treeModel.data!.childrens![indextwo].name!,
                                    treeModel.data!.childrens![indextwo].gender,
                                    treeModel.data!.childrens![indextwo]
                                                .maritalStatus ==
                                            "Single"
                                        ? true
                                        : false,
                                    treeModel.data!.childrens![indextwo].amI,
                                    treeModel.data!.childrens![indextwo].isRoot,
                                    treeModel.data!.childrens![indextwo]
                                                .gender ==
                                            "Male"
                                        ? "Son"
                                        : "Daughter",
                                    treeModel.data!.childrens![indextwo]
                                                .fatherId !=
                                            null
                                        ? true
                                        : false,
                                    treeModel.data!.mainFamilyId!.familyName,
                                    true),
                              )

                              // Flexible(
                              //   child: Stack(
                              //     children: [
                              //       Container(
                              //           height: 120,
                              //           width:
                              //               MediaQuery.of(context).size.width / 3,
                              //           padding: const EdgeInsets.all(14.0),
                              //           decoration: BoxDecoration(
                              //               color: treeModel
                              //                           .data!
                              //                           .childrens![indextwo]
                              //                           .amI ==
                              //                       true
                              //                   ? Colors.white
                              //                   : Colors.white,
                              //               borderRadius:
                              //                   BorderRadius.circular(8),
                              //               boxShadow: [
                              //                 BoxShadow(
                              //                     color: Colors.grey
                              //                         .withOpacity(0.5)),
                              //               ]),
                              //           child: const Column(
                              //             children: [
                              //               // Stack(
                              //               //   children: [
                              //               //     Container(
                              //               //       width: 60,
                              //               //       height: 60,
                              //               //       color: Colors.blue,
                              //               //       child: const Column(children: [
                              //               //         Text("jdn"),
                              //               //         Text("dvfv")
                              //               //       ]),
                              //               //     ),
                              //               //     const Positioned(
                              //               //       top: -10,
                              //               //       child: CircleAvatar(
                              //               //         backgroundImage: AssetImage(
                              //               //             "assets/familyilogo.jpg"),
                              //               //         backgroundColor: Colors.grey,
                              //               //       ),
                              //               //     ),
                              //               //   ],
                              //               // )
                              //             ],
                              //           )

                              //           // Stack(
                              //           //   children: [
                              //           //     const Column(
                              //           //       mainAxisAlignment: MainAxisAlignment.center,
                              //           //       crossAxisAlignment:
                              //           //           CrossAxisAlignment.center,
                              //           //       children: [
                              //           //         Text("Hecnl")
                              //           //         // const CircleAvatar(
                              //           //         //   backgroundImage: AssetImage(
                              //           //         //       "assets/familyilogo.jpg"),
                              //           //         //   backgroundColor: Colors.grey,
                              //           //         // ),
                              //           //         // SizedBox(
                              //           //         //   height: 20,
                              //           //         //   child: Text(
                              //           //         //     treeModel
                              //           //         //         .data!.childrens![indextwo].name!,
                              //           //         //     style: const TextStyle(
                              //           //         //         color: Colors.white,
                              //           //         //         fontWeight: FontWeight.bold,
                              //           //         //         fontSize: 15),
                              //           //         //   ),
                              //           //         // ),
                              //           //       ],
                              //           //     ),
                              //           //     treeModel.data!.childrens![indextwo].amI !=
                              //           //                 true ||
                              //           //             treeModel.data!.childrens![indextwo]
                              //           //                     .isRoot !=
                              //           //                 true
                              //           //         ? const SizedBox.shrink()
                              //           //         : Positioned(
                              //           //             left: 70,
                              //           //             child: InkWell(
                              //           //               child: const CircleAvatar(
                              //           //                 backgroundColor: Colors.green,
                              //           //                 radius: 11,
                              //           //                 child: Icon(
                              //           //                   Icons.add,
                              //           //                   size: 16,
                              //           //                 ),
                              //           //               ),
                              //           //               onTap: () {
                              //           //                 Helper.showAdd(
                              //           //                     context,
                              //           //                     treeModel.data!
                              //           //                         .childrens![indextwo].sId,
                              //           //                     treeModel
                              //           //                                 .data!
                              //           //                                 .childrens![
                              //           //                                     indextwo]
                              //           //                                 .maritalStatus !=
                              //           //                             "Single"
                              //           //                         ? false
                              //           //                         : true,
                              //           //                     treeModel
                              //           //                                 .data!
                              //           //                                 .childrens![
                              //           //                                     indextwo]
                              //           //                                 .maritalStatus !=
                              //           //                             "Single"
                              //           //                         ? true
                              //           //                         : false,
                              //           //                     treeModel
                              //           //                                 .data!
                              //           //                                 .childrens![
                              //           //                                     indextwo]
                              //           //                                 .fatherId ==
                              //           //                             null
                              //           //                         ? true
                              //           //                         : false);
                              //           //               },
                              //           //             )),
                              //           //     // Positioned(
                              //           //     //     left: 32,
                              //           //     //     child: treeModel
                              //           //     //                 .data!
                              //           //     //                 .childrens![indextwo]
                              //           //     //                 .gender! ==
                              //           //     //             "Male"
                              //           //     //         ? const Icon(
                              //           //     //             Icons.male,
                              //           //     //             size: 16,
                              //           //     //           )
                              //           //     //         : const Icon(
                              //           //     //             Icons.female,
                              //           //     //             size: 16,
                              //           //     //           ))
                              //           //   ],
                              //           // ),

                              //           //  Text(
                              //           //   treeModel.data!.childrens![index].name!,
                              //           //   style: const TextStyle(
                              //           //       color: Colors.white,
                              //           //       fontWeight: FontWeight.bold,
                              //           //       fontSize: 16),
                              //           // ),
                              //           ),
                              //       Positioned(
                              //         top: 34,
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(18),
                              //           child: Container(
                              //             color: const Color(0xff42b0ff),
                              //             height: 85,
                              //             width:
                              //                 MediaQuery.of(context).size.width /
                              //                     3,
                              //           ),
                              //         ),
                              //       ),
                              //       Positioned(
                              //         top: 0,
                              //         right:
                              //             MediaQuery.of(context).size.width / 14,
                              //         child: Column(
                              //           children: [
                              //             const CircleAvatar(
                              //               backgroundImage: AssetImage(
                              //                   "assets/images/profiles/profile1.png"),
                              //               radius: 35,
                              //               backgroundColor: Colors.grey,
                              //             ),
                              //             const SizedBox(
                              //               height: 3,
                              //             ),
                              //             Text(
                              //               treeModel.data!.childrens![indextwo]
                              //                           .gender ==
                              //                       "Male"
                              //                   ? "Son"
                              //                   : "Daughter",
                              //               style: const TextStyle(
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 8),
                              //             ),
                              //             Text(
                              //               treeModel
                              //                   .data!.childrens![indextwo].name!,
                              //               style: const TextStyle(
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 12),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // SizedBox(
                              //   height: 30,
                              //   width: MediaQuery.of(context).size.width / 3,
                              //   child: ClipRRect(
                              //     borderRadius: const BorderRadius.only(
                              //         bottomLeft: Radius.circular(18),
                              //         bottomRight: Radius.circular(18)),
                              //     child: MaterialButton(
                              //         color: Colors.green[300],
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             const Text(
                              //               "Profile",
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 15),
                              //             ),
                              //             treeModel.data!.childrens![indextwo]
                              //                         .maritalStatus ==
                              //                     "Married"
                              //                 ? const CircleAvatar(
                              //                     radius: 10,
                              //                     backgroundImage: AssetImage(
                              //                         "assets/wedding-rings.png"))
                              //                 : const SizedBox.shrink()
                              //           ],
                              //         ),
                              //         onPressed: () {
                              //           Helper.push(
                              //               context,
                              //               ProfileDetailed(
                              //                 userId: treeModel
                              //                     .data!.childrens![indextwo].sId!
                              //                     .toString(),
                              //               ));
                              //         }),
                              //   ),
                              // )
                            ],
                          ),
                        );
                      })),
            ],
          ))

          //     child: Row(
          //   children: List.generate(
          //       treeModel.data!.childrens!.length,
          //       (index) => Row(
          //             children: [
          //               InkWell(
          //                 onTap: () => treeModel
          //                             .data!.childrens![index].maritalStatus !=
          //                         "Single"
          //                     ? context.read<MainBloc>().add(GetUser(
          //                         userID: treeModel.data!.childrens![index].sId))
          //                     : Helper.showToast(
          //                         msg: treeModel
          //                             .data!.childrens![index].maritalStatus),
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       width: MediaQuery.of(context).size.width / 3,
          //                       padding: const EdgeInsets.all(14.0),
          //                       decoration: BoxDecoration(
          //                           color:
          //                               treeModel.data!.childrens![index].amI ==
          //                                       true
          //                                   ? Colors.blue[200]
          //                                   : Colors.blue[200],
          //                           borderRadius: const BorderRadius.only(
          //                               topLeft: Radius.circular(18),
          //                               topRight: Radius.circular(18)),
          //                           boxShadow: [
          //                             BoxShadow(
          //                                 color: Colors.grey.withOpacity(0.5)),
          //                           ]),
          //                       child: Stack(
          //                         children: [
          //                           Column(
          //                             children: [
          //                               const CircleAvatar(
          //                                 backgroundImage: AssetImage(
          //                                     "assets/familyilogo.jpg"),
          //                                 backgroundColor: Colors.grey,
          //                               ),
          //                               Text(
          //                                 treeModel.data!.childrens![index].name!,
          //                                 style: const TextStyle(
          //                                     color: Colors.white,
          //                                     fontWeight: FontWeight.bold,
          //                                     fontSize: 15),
          //                               ),
          //                             ],
          //                           ),
          //                           Positioned(
          //                               left: 76,
          //                               child: treeModel.data!.childrens![index]
          //                                           .gender! ==
          //                                       "Male"
          //                                   ? const Icon(
          //                                       Icons.male,
          //                                       size: 16,
          //                                     )
          //                                   : const Icon(
          //                                       Icons.female,
          //                                       size: 16,
          //                                     ))
          //                         ],
          //                       ),

          //                       //  Text(
          //                       //   treeModel.data!.childrens![index].name!,
          //                       //   style: const TextStyle(
          //                       //       color: Colors.white,
          //                       //       fontWeight: FontWeight.bold,
          //                       //       fontSize: 16),
          //                       // ),
          //                     ),
          //                     SizedBox(
          //                       height: 30,
          //                       width: MediaQuery.of(context).size.width / 3,
          //                       child: ClipRRect(
          //                         borderRadius: const BorderRadius.only(
          //                             bottomLeft: Radius.circular(18),
          //                             bottomRight: Radius.circular(18)),
          //                         child: MaterialButton(
          //                             color: Colors.green[300],
          //                             child: const Text(
          //                               "Profile",
          //                               style: TextStyle(
          //                                   color: Colors.white,
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 15),
          //                             ),
          //                             onPressed: () {
          //                               Helper.push(
          //                                   context,
          //                                   ProfileDetailed(
          //                                     userId: treeModel
          //                                         .data!.childrens![index].sId!
          //                                         .toString(),
          //                                   ));
          //                             }),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),

          //               Helper.allowWidth(10),
          //             ],
          //           )),
          // ))
        ],
      ),
    );
  }

  buildParentWithChild(TreeModel treeModel, bool? issingle) {
    return Column(
      children: [
        OuterContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => context
                    .read<MainBloc>()
                    .add(GetUser(userID: treeModel.data!.fatherId!.sId)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                          color: treeModel.data!.fatherId!.amI == true
                              ? Colors.blue
                              : Colors.blue[200],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5)),
                          ]),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/familyilogo.jpg"),
                                backgroundColor: Colors.grey,
                              ),
                              Text(
                                treeModel.data!.fatherId!.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          treeModel.data!.fatherId!.amI != true ||
                                  treeModel.data!.fatherId!.isRoot != true
                              ? const SizedBox.shrink()
                              : Positioned(
                                  left: 70,
                                  child: InkWell(
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 11,
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                      ),
                                    ),
                                    onTap: () {
                                      Helper.showAdd(
                                          context,
                                          treeModel.data!.fatherId!.sId,
                                          treeModel.data!.fatherId != null
                                              ? false
                                              : true,
                                          treeModel.data!.fatherId == null
                                              ? false
                                              : true,
                                          treeModel.data!.fatherId == null
                                              ? true
                                              : false);
                                    },
                                  )),
                          Positioned(
                              left: 30,
                              child: treeModel.data!.fatherId!.gender == "Male"
                                  ? const Icon(
                                      Icons.male,
                                      size: 16,
                                    )
                                  : const Icon(
                                      Icons.female,
                                      size: 16,
                                    ))
                        ],
                      ),

                      //  Text(
                      //   treeModel.data!.fatherId!.name!,
                      //   style: const TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 16),
                      // ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18)),
                        child: MaterialButton(
                            color: Colors.green[300],
                            child: const Row(
                              children: [
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                // CircleAvatar(
                                //   backgroundImage:
                                //       AssetImage("assets/wedding.png"),
                                // )
                              ],
                            ),
                            onPressed: () {
                              Helper.push(
                                  context,
                                  ProfileDetailed(
                                    userId: treeModel.data!.fatherId!.sId!
                                        .toString(),
                                  ));
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Helper.hDivider(width: MediaQuery.of(context).size.width / 9),
              InkWell(
                onTap: () => context
                    .read<MainBloc>()
                    .add(GetUser(userID: treeModel.data!.motherId!.sId)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                          color: treeModel.data!.motherId!.amI == true
                              ? Colors.blue
                              : Colors.blue[200],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5)),
                          ]),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/familyilogo.jpg"),
                                backgroundColor: Colors.grey,
                              ),
                              Text(
                                treeModel.data!.motherId!.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          treeModel.data!.motherId!.amI != true ||
                                  treeModel.data!.motherId!.isRoot != true
                              ? const SizedBox.shrink()
                              : Positioned(
                                  left: 70,
                                  child: InkWell(
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 11,
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                      ),
                                    ),
                                    onTap: () {
                                      Helper.showAdd(
                                          context,
                                          treeModel.data!.motherId!.sId,
                                          treeModel.data!.motherId == null
                                              ? true
                                              : false,
                                          treeModel.data!.motherId == null
                                              ? false
                                              : true,
                                          treeModel.data!.motherId == null
                                              ? true
                                              : false);
                                    },
                                  )),
                          Positioned(
                              left: 30,
                              child: treeModel.data!.motherId!.gender! == "Male"
                                  ? const Icon(
                                      Icons.male,
                                      size: 16,
                                    )
                                  : const Icon(
                                      Icons.female,
                                      size: 16,
                                    ))
                        ],
                      ),

                      //  Text(
                      //   treeModel.data!.motherId!.name!,
                      //   style: const TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 16),
                      // ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18)),
                        child: MaterialButton(
                            color: Colors.green[300],
                            child: const Row(
                              children: [
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                // CircleAvatar(
                                //   backgroundImage:
                                //       AssetImage("assets/wedding.png"),
                                // )
                              ],
                            ),
                            onPressed: () {
                              Helper.push(
                                  context,
                                  ProfileDetailed(
                                    userId: treeModel.data!.motherId!.sId!
                                        .toString(),
                                  ));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Helper.vDivider(height: 80.0),
        OuterContainer(
          child: InkWell(
            onTap: () => treeModel.data!.maritalStatus != "Single"
                ? context
                    .read<MainBloc>()
                    .add(GetUser(userID: treeModel.data!.sId))
                : treeModel.data!.amI!
                    ? Helper.showAdd(
                        context, treeModel.data!.sId, true, false, true)
                    : Helper.showToast(msg: treeModel.data!.maritalStatus),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      color:
                          treeModel.data!.amI! ? Colors.blue : Colors.blue[200],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5)),
                      ]),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/familyilogo.jpg"),
                            backgroundColor: Colors.grey,
                          ),
                          Text(
                            treeModel.data!.name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      treeModel.data!.amI != true ||
                              treeModel.data!.isRoot != true
                          ? const SizedBox.shrink()
                          : Positioned(
                              left: 70,
                              child: InkWell(
                                child: const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 11,
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                ),
                                onTap: () {
                                  Helper.showAdd(
                                      context,
                                      treeModel.data!.sId,
                                      treeModel.data!.spouseId != null
                                          ? false
                                          : true,
                                      treeModel.data!.spouseId == null
                                          ? false
                                          : true,
                                      treeModel.data!.familyId == null
                                          ? true
                                          : false);
                                },
                              )),
                      Positioned(
                          left: 36,
                          child: treeModel.data!.gender! == "Male"
                              ? const Icon(
                                  Icons.male,
                                  size: 16,
                                )
                              : const Icon(
                                  Icons.female,
                                  size: 16,
                                ))
                    ],
                  ),
                  // Text(
                  //   treeModel.data!.name!,
                  //   style: const TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16),
                  // ),
                ),
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18)),
                    child: MaterialButton(
                        color: Colors.green[300],
                        child: const Row(
                          children: [
                            Text(
                              "Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            // CircleAvatar(
                            //   backgroundImage: AssetImage("assets/wedding.png"),
                            // )
                          ],
                        ),
                        onPressed: () {
                          Helper.push(
                              context,
                              ProfileDetailed(
                                userId: treeModel.data!.sId!.toString(),
                              ));
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildParentWithChildWithSpouse(TreeModel treeModel) {
    return Column(
      children: [
        // OuterContainer(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       InkWell(
        //         onTap: () => context
        //             .read<MainBloc>()
        //             .add(GetUser(userID: treeModel.data!.fatherId!.sId)),
        //         child: Column(
        //           children: [
        //             Container(
        //               width: MediaQuery.of(context).size.width / 3,
        //               padding: const EdgeInsets.all(14.0),
        //               decoration: BoxDecoration(
        //                   color: treeModel.data!.fatherId!.amI == true
        //                       ? Colors.blue
        //                       : Colors.blue[200],
        //                   borderRadius: const BorderRadius.only(
        //                       topLeft: Radius.circular(18),
        //                       topRight: Radius.circular(18)),
        //                   boxShadow: [
        //                     BoxShadow(color: Colors.grey.withOpacity(0.5)),
        //                   ]),
        //               child: Stack(
        //                 children: [
        //                   Column(
        //                     children: [
        //                       const CircleAvatar(
        //                         backgroundImage:
        //                             AssetImage("assets/familyilogo.jpg"),
        //                         backgroundColor: Colors.grey,
        //                       ),
        //                       Text(
        //                         treeModel.data!.fatherId!.name!,
        //                         style: const TextStyle(
        //                             color: Colors.white,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 15),
        //                       ),
        //                     ],
        //                   ),
        //                   Positioned(
        //                       left: 76,
        //                       child: treeModel.data!.fatherId!.gender! == "Male"
        //                           ? const Icon(
        //                               Icons.male,
        //                               size: 16,
        //                             )
        //                           : const Icon(
        //                               Icons.female,
        //                               size: 16,
        //                             ))
        //                 ],
        //               ),
        //               //  Text(
        //               //   treeModel.data!.fatherId!.name!,
        //               //   style: const TextStyle(
        //               //       color: Colors.white,
        //               //       fontWeight: FontWeight.bold,
        //               //       fontSize: 16),
        //               // ),
        //             ),
        //             SizedBox(
        //               height: 30,
        //               width: MediaQuery.of(context).size.width / 3,
        //               child: ClipRRect(
        //                 borderRadius: const BorderRadius.only(
        //                     bottomLeft: Radius.circular(18),
        //                     bottomRight: Radius.circular(18)),
        //                 child: MaterialButton(
        //                     color: Colors.green[300],
        //                     child: const Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Text(
        //                           "Profile",
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 15),
        //                         ),
        //                         // CircleAvatar(
        //                         //   radius: 10,
        //                         //   backgroundImage:
        //                         //       AssetImage("assets/wedding-rings.png"),
        //                         // )
        //                       ],
        //                     ),
        //                     onPressed: () {
        //                       Helper.push(
        //                           context,
        //                           ProfileDetailed(
        //                             userId: treeModel.data!.fatherId!.sId!
        //                                 .toString(),
        //                           ));
        //                     }),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Helper.hDivider(width: MediaQuery.of(context).size.width / 9),
        //       InkWell(
        //         onTap: () => context
        //             .read<MainBloc>()
        //             .add(GetUser(userID: treeModel.data!.motherId!.sId)),
        //         child: Column(
        //           children: [
        //             Container(
        //               width: MediaQuery.of(context).size.width / 3,
        //               padding: const EdgeInsets.all(14.0),
        //               decoration: BoxDecoration(
        //                   color: treeModel.data!.motherId!.amI == true
        //                       ? Colors.blue
        //                       : Colors.blue[200],
        //                   borderRadius: const BorderRadius.only(
        //                       topLeft: Radius.circular(18),
        //                       topRight: Radius.circular(18)),
        //                   boxShadow: [
        //                     BoxShadow(color: Colors.grey.withOpacity(0.5)),
        //                   ]),
        //               child: Stack(
        //                 children: [
        //                   Column(
        //                     children: [
        //                       const CircleAvatar(
        //                         backgroundImage:
        //                             AssetImage("assets/familyilogo.jpg"),
        //                         backgroundColor: Colors.grey,
        //                       ),
        //                       SizedBox(
        //                         height: 20,
        //                         child: Text(
        //                           treeModel.data!.motherId!.name!,
        //                           style: const TextStyle(
        //                               color: Colors.white,
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 15),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   Positioned(
        //                       left: 76,
        //                       child: treeModel.data!.motherId!.gender! == "Male"
        //                           ? const Icon(
        //                               Icons.male,
        //                               size: 16,
        //                             )
        //                           : const Icon(
        //                               Icons.female,
        //                               size: 16,
        //                             ))
        //                 ],
        //               ),
        //               // Text(
        //               //   treeModel.data!.motherId!.name!,
        //               //   style: const TextStyle(
        //               //       color: Colors.white,
        //               //       fontWeight: FontWeight.bold,
        //               //       fontSize: 16),
        //               // ),
        //             ),
        //             SizedBox(
        //               height: 30,
        //               width: MediaQuery.of(context).size.width / 3,
        //               child: ClipRRect(
        //                 borderRadius: const BorderRadius.only(
        //                     bottomLeft: Radius.circular(18),
        //                     bottomRight: Radius.circular(18)),
        //                 child: MaterialButton(
        //                     color: Colors.green[300],
        //                     child: const Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Text(
        //                           "Profile",
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 15),
        //                         ),
        //                         // CircleAvatar(
        //                         //   radius: 10,
        //                         //   backgroundImage:
        //                         //       AssetImage("assets/wedding-rings.png"),
        //                         // )
        //                       ],
        //                     ),
        //                     onPressed: () {
        //                       Helper.push(
        //                           context,
        //                           ProfileDetailed(
        //                             userId: treeModel.data!.motherId!.sId!
        //                                 .toString(),
        //                           ));
        //                     }),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Helper.vDivider(height: 80.0),
        OuterContainer(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => context.read<MainBloc>().add(
                            GetUser(userID: treeModel.data!.fatherId!.sId)),
                        child: Helper.myprofilecard(
                            context,
                            "assets/images/profiles/profile1.png",
                            treeModel.data!.fatherId!.sId,
                            treeModel.data!.fatherId!.name!,
                            treeModel.data!.fatherId!.gender,
                            treeModel.data!.fatherId!.maritalStatus == "Single"
                                ? true
                                : false,
                            treeModel.data!.fatherId!.amI,
                            treeModel.data!.fatherId!.isRoot,
                            "Father",
                            treeModel.data!.fatherId!.familyId != null
                                ? true
                                : false,
                            treeModel.data!.mainFamilyId!.familyName,
                            false),
                        //  Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(8.0))),
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     "${treeModel.data!.fatherId!.name}",
                        //     style: TextStyle(
                        //         color: treeModel.data!.fatherId!.amI == true
                        //             ? Colors.green
                        //             : Colors.black,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ),
                      Helper.allowHeight(25),
                      // Helper.allowHeight(5),
                      // Helper.vDivider(height: 27.0),
                      // Helper.allowHeight(5),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 110.5),
                  Column(
                    children: [
                      Image.asset("assets/images/grandparents.png", height: 60),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 110.5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => context.read<MainBloc>().add(
                            GetUser(userID: treeModel.data!.fatherId!.sId)),
                        child: Helper.myprofilecard(
                            context,
                            "assets/images/profiles/profile7.png",
                            treeModel.data!.motherId!.sId,
                            treeModel.data!.motherId!.name!,
                            treeModel.data!.motherId!.gender,
                            treeModel.data!.motherId!.maritalStatus == "Single"
                                ? true
                                : false,
                            treeModel.data!.motherId!.amI,
                            treeModel.data!.motherId!.isRoot,
                            "Mother",
                            treeModel.data!.motherId!.familyId != null
                                ? true
                                : false,
                            "Family Name",
                            false),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(8.0))),
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     "${treeModel.data!.motherId!.name}",
                        //     style: TextStyle(
                        //         color: treeModel.data!.motherId!.amI == true
                        //             ? Colors.green
                        //             : Colors.black,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ),
                      Helper.allowHeight(35),
                      const SizedBox.shrink()
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // treeModel.data!.amI == true
                      //     ? Helper.showAdd(
                      //         context,
                      //         treeModel.data!.sId,
                      //         treeModel.data!.spouseId != null ? false : true,
                      //         treeModel.data!.spouseId != null ? true : false,
                      //         true)
                      //     :

                      BlocProvider.of<MainBloc>(context)
                          .add(GetUser(userID: treeModel.data!.sId));
// BlocProvider
//                     .of<MainBloc>(contex)
//                     .add(GetUser(userID: treeModel.data!.sId)),
                    },
                    child: Column(
                      children: [
                        Helper.myprofilecard(
                            context,
                            "assets/images/profiles/profile8.png",
                            treeModel.data!.sId,
                            treeModel.data!.name!,
                            treeModel.data!.gender,
                            treeModel.data!.maritalStatus == "Single"
                                ? true
                                : false,
                            treeModel.data!.amI,
                            treeModel.data!.isRoot,
                            "You",
                            treeModel.data!.fatherId != null ? true : false,
                            treeModel.data!.mainFamilyId!.familyName,
                            false),
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 3,
                        //   padding: const EdgeInsets.all(14.0),
                        //   decoration: BoxDecoration(
                        //       color: treeModel.data!.amI == true
                        //           ? Colors.blue
                        //           : Colors.blue[200],
                        //       borderRadius: const BorderRadius.only(
                        //           topLeft: Radius.circular(18),
                        //           topRight: Radius.circular(18)),
                        //       boxShadow: [
                        //         BoxShadow(color: Colors.grey.withOpacity(0.5)),
                        //       ]),
                        //   child: Stack(
                        //     children: [
                        //       Column(
                        //         children: [
                        //           const CircleAvatar(
                        //             backgroundImage:
                        //                 AssetImage("assets/familyilogo.jpg"),
                        //             backgroundColor: Colors.grey,
                        //           ),
                        //           SizedBox(
                        //             height: 20,
                        //             child: Text(
                        //               treeModel.data!.name!,
                        //               style: const TextStyle(
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 15),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       treeModel.data!.amI != true ||
                        //               treeModel.data!.isRoot == true
                        //           ? const SizedBox.shrink()
                        //           : Positioned(
                        //               left: 70,
                        //               child: InkWell(
                        //                 child: const CircleAvatar(
                        //                   backgroundColor: Colors.green,
                        //                   radius: 11,
                        //                   child: Icon(
                        //                     Icons.add,
                        //                     size: 16,
                        //                   ),
                        //                 ),
                        //                 onTap: () {
                        //                   Helper.showAdd(
                        //                       context,
                        //                       treeModel.data!.sId,
                        //                       treeModel.data!.spouseId == null
                        //                           ? true
                        //                           : false,
                        //                       treeModel.data!.spouseId == null
                        //                           ? false
                        //                           : true,
                        //                       treeModel.data!.fatherId == null
                        //                           ? true
                        //                           : false);
                        //                 },
                        //               )),
                        //       Positioned(
                        //           left: 45,
                        //           child: treeModel.data!.gender! == "Male"
                        //               ? const Icon(
                        //                   Icons.male,
                        //                   size: 16,
                        //                 )
                        //               : const Icon(
                        //                   Icons.female,
                        //                   size: 16,
                        //                 ))
                        //     ],
                        //   ),

                        //   // Text(
                        //   //   treeModel.data!.name!,
                        //   //   style: const TextStyle(
                        //   //       color: Colors.white,
                        //   //       fontWeight: FontWeight.bold,
                        //   //       fontSize: 16),
                        //   // ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        //   width: MediaQuery.of(context).size.width / 3,
                        //   child: ClipRRect(
                        //     borderRadius: const BorderRadius.only(
                        //         bottomLeft: Radius.circular(18),
                        //         bottomRight: Radius.circular(18)),
                        //     child: MaterialButton(
                        //         color: Colors.green[300],
                        //         child: const Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               "Profile",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 15),
                        //             ),
                        //             // treeModel.data!.spouseId != null
                        //             //     ? const CircleAvatar(
                        //             //         radius: 10,
                        //             //         backgroundImage: AssetImage(
                        //             //             "assets/wedding-rings.png"))
                        //             //     : const SizedBox.shrink()
                        //           ],
                        //         ),
                        //         onPressed: () {
                        //           Helper.push(
                        //               context,
                        //               ProfileDetailed(
                        //                 userId: treeModel.data!.sId!.toString(),
                        //               ));
                        //         }),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 110.5),
                  Column(
                    children: [
                      Image.asset("assets/images/parents.png", height: 60),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 110.5),
                  InkWell(
                    onTap: () => context
                        .read<MainBloc>()
                        .add(GetUser(userID: treeModel.data!.spouseId!.sId)),
                    child: Helper.myprofilecard(
                        context,
                        "assets/images/profiles/profile2.png",
                        treeModel.data!.spouseId!.sId,
                        treeModel.data!.spouseId!.name!,
                        treeModel.data!.spouseId!.gender,
                        treeModel.data!.spouseId!.maritalStatus == "Single"
                            ? true
                            : false,
                        treeModel.data!.spouseId!.amI,
                        treeModel.data!.spouseId!.isRoot,
                        "Spouse",
                        treeModel.data!.spouseId!.mainFamilyId != null
                            ? true
                            : false,
                        "Family Name",
                        false),
                    // Column(
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 3,
                    //       // height: MediaQuery.of(context).size.height / 8,
                    //       padding: const EdgeInsets.all(14.0),
                    //       decoration: BoxDecoration(
                    //           color: treeModel.data!.spouseId!.amI == true
                    //               ? Colors.blue
                    //               : Colors.blue[200],
                    //           borderRadius: const BorderRadius.only(
                    //               topLeft: Radius.circular(18),
                    //               topRight: Radius.circular(18)),
                    //           boxShadow: [
                    //             BoxShadow(color: Colors.grey.withOpacity(0.5)),
                    //           ]),
                    //       child: Stack(
                    //         children: [
                    //           Column(
                    //             children: [
                    //               const CircleAvatar(
                    //                 backgroundImage:
                    //                     AssetImage("assets/familyilogo.jpg"),
                    //                 backgroundColor: Colors.grey,
                    //               ),
                    //               SizedBox(
                    //                 width: 88,
                    //                 height: 22,
                    //                 child: Text(
                    //                   treeModel.data!.spouseId!.name!,
                    //                   style: const TextStyle(
                    //                       color: Colors.white,
                    //                       overflow: TextOverflow.clip,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 15),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           treeModel.data!.spouseId!.amI != true ||
                    //                   treeModel.data!.spouseId!.isRoot == true
                    //               ? const SizedBox.shrink()
                    //               : Positioned(
                    //                   left: 70,
                    //                   child: InkWell(
                    //                     child: const CircleAvatar(
                    //                       backgroundColor: Colors.green,
                    //                       radius: 11,
                    //                       child: Icon(
                    //                         Icons.add,
                    //                         size: 16,
                    //                       ),
                    //                     ),
                    //                     onTap: () {
                    //                       Helper.showAdd(
                    //                           context,
                    //                           treeModel.data!.sId,
                    //                           treeModel.data!.spouseId == null
                    //                               ? true
                    //                               : false,
                    //                           treeModel.data!.spouseId == null
                    //                               ? false
                    //                               : true,
                    //                           treeModel.data!.spouseId!
                    //                                       .mainFamilyId ==
                    //                                   null
                    //                               ? true
                    //                               : false);
                    //                     },
                    //                   )),
                    //           Positioned(
                    //               left: 48,
                    //               child: treeModel.data!.spouseId!.gender! ==
                    //                       "Male"
                    //                   ? const Icon(
                    //                       Icons.male,
                    //                       size: 16,
                    //                     )
                    //                   : const Icon(
                    //                       Icons.female,
                    //                       size: 16,
                    //                     ))
                    //         ],
                    //       ),

                    //       //  Text(
                    //       //   treeModel.data!.spouseId!.name!,
                    //       //   style: const TextStyle(
                    //       //       color: Colors.white,
                    //       //       fontWeight: FontWeight.bold,
                    //       //       fontSize: 16),
                    //       // ),
                    //     ),
                    //     SizedBox(
                    //       height: 30,
                    //       width: MediaQuery.of(context).size.width / 3,
                    //       child: ClipRRect(
                    //         borderRadius: const BorderRadius.only(
                    //             bottomLeft: Radius.circular(18),
                    //             bottomRight: Radius.circular(18)),
                    //         child: MaterialButton(
                    //             color: Colors.green[300],
                    //             child: const Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   "Profile",
                    //                   style: TextStyle(
                    //                       color: Colors.white,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 15),
                    //                 ),
                    //                 // treeModel.data!.spouseId != null
                    //                 //     ? const CircleAvatar(
                    //                 //         radius: 10,
                    //                 //         backgroundImage: AssetImage(
                    //                 //             "assets/wedding-rings.png"))
                    //                 //     : const SizedBox.shrink()
                    //               ],
                    //             ),
                    //             onPressed: () {
                    //               Helper.push(
                    //                   context,
                    //                   ProfileDetailed(
                    //                     userId: treeModel.data!.spouseId!.sId!
                    //                         .toString(),
                    //                   ));
                    //             }),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//  buildParentWithChild(TreeModel treeModel, bool? issingle) {
//     return Column(
//       children: [
//         OuterContainer(
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(8.0))),
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Father - ${treeModel.data!.fatherId!.name}\nMother - ${treeModel.data!.motherId!.name}",
//                           style: const TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         )),
//                     onTap: () {},
//                   ),
//                   Helper.allowHeight(5),
//                   Helper.vDivider(height: 20.0),
//                   Helper.allowHeight(5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       InkWell(
//                         onTap: () => {},
//                         child: Container(
//                           padding: const EdgeInsets.all(14.0),
//                           decoration: BoxDecoration(
//                               color: Colors.blueAccent,
//                               borderRadius: BorderRadius.circular(18.0),
//                               boxShadow: [
//                                 BoxShadow(color: Colors.grey.withOpacity(0.5)),
//                               ]),
//                           child: Text(
//                             treeModel.data!.name!,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       ),
//                       Helper.hDivider(width: 80.0),
//                       InkWell(
//                         onTap: () => {},
//                         child: Container(
//                           padding: const EdgeInsets.all(14.0),
//                           decoration: BoxDecoration(
//                               color: Colors.blueAccent,
//                               borderRadius: BorderRadius.circular(18.0),
//                               boxShadow: [
//                                 BoxShadow(color: Colors.grey.withOpacity(0.5)),
//                               ]),
//                           child: treeModel.data!.spouseId == null
//                               ? const SizedBox.shrink()
//                               : Text(
//                                   treeModel.data!.spouseId!.name!,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               // Container(
//               //   padding: const EdgeInsets.all(14.0),
//               //   decoration: BoxDecoration(
//               //       color: Colors.blueAccent,
//               //       borderRadius: BorderRadius.circular(18.0),
//               //       boxShadow: [
//               //         BoxShadow(color: Colors.grey.withOpacity(0.5)),
//               //       ]),
//               //   child: Flexible(
//               //     child: Text(
//               //       treeModel.data!.spouseId!.name!,
//               //       overflow: TextOverflow.ellipsis,
//               //       style: const TextStyle(
//               //           color: Colors.white,
//               //           fontWeight: FontWeight.bold,
//               //           fontSize: 16),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
