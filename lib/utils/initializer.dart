import 'package:family_tree_app/logic/models/generations.dart';
import 'package:flutter/material.dart';

class Initializer {
   static GlobalKey<FormState> registerKey = GlobalKey<FormState>();
    static GlobalKey<FormState> loginKey = GlobalKey<FormState>();

       static GlobalKey<FormState> adddatafromKey = GlobalKey<FormState>();
    static GlobalKey<FormState> addparentsdatafromKey = GlobalKey<FormState>();
  static Generations generations = Generations(generations: []);

  static List<FamilyModel> familydata = [
    FamilyModel(
        hasChildrens: true,
        hasSpouse: true,
        type: 'user',
        horw: "Wife",
        childres: [
          FamilyModel(
              hasChildrens: true,
              hasSpouse: true,
              type: 'user',
              horw: "Wife",
              childres: [
                FamilyModel(
                  hasChildrens: false,
                  hasSpouse: false,
                  type: 'user',
                )
              ]),
          FamilyModel(
            hasChildrens: false,
            hasSpouse: false,
            type: 'user',
          )
        ]),
  ];
}

class FamilyModel {
  String? type;
  bool? hasChildrens, hasSpouse;
  String? horw;
  List<FamilyModel>? childres;
  FamilyModel(
      {required this.hasChildrens,
      required this.type,
      this.childres,
      this.horw,
      required this.hasSpouse});
}
