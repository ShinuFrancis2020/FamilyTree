class TreeModel {
  bool? status;
  String? msg;
  Data? data;

  TreeModel({this.status, this.msg, this.data});

  TreeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  MainFamilyId? mainFamilyId;
  MainFamilyId? familyId;
  FatherId? fatherId;
  MotherId? motherId;
  String? role;
  bool? isRoot;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? status;
  String? gender;
  String? address;
  String? phone;
  String? dateOfBirth;
  String? createDate;
  String? updateDate;
  int? iV;
  String? galleryVisibility;
  String? maritalStatus;
  SpouseId? spouseId;

  bool? amI;
  List<Childrens>? childrens;

  Data(
      {this.sId,
      this.amI,
      this.mainFamilyId,
      this.familyId,
      this.fatherId,
      this.motherId,
      this.role,
      this.isRoot,
      this.name,
      this.email,
      this.isEmailVerified,
      this.status,
      this.gender,
      this.address,
      this.phone,
      this.dateOfBirth,
      this.createDate,
      this.updateDate,
      this.iV,
      this.galleryVisibility,
      this.maritalStatus,
      this.spouseId,
      this.childrens});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fatherId =
        json['fatherId'] != null ? FatherId.fromJson(json['fatherId']) : null;
    motherId =
        json['motherId'] != null ? MotherId.fromJson(json['motherId']) : null;
    mainFamilyId = json['mainFamilyId'] != null
        ? MainFamilyId.fromJson(json['mainFamilyId'])
        : null;
    familyId = json['familyId'] != null
        ? MainFamilyId.fromJson(json['familyId'])
        : null;
    role = json['role'];
    isRoot = json['isRoot'];
    name = json['name'];
    amI = json['amI'];

    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    status = json['status'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    dateOfBirth = json['dateOfBirth'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    galleryVisibility = json['galleryVisibility'];
    maritalStatus = json['maritalStatus'];
    spouseId =
        json['spouseId'] != null ? SpouseId.fromJson(json['spouseId']) : null;
    if (json['childrens'] != null) {
      childrens = <Childrens>[];
      json['childrens'].forEach((v) {
        childrens!.add(Childrens.fromJson(v));
      });
    }
  }
}

class FatherId {
  String? sId;
  String? mainFamilyId;
  String? role;
  bool? isRoot;
  bool? amI;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? maritalStatus;
  String? spouseId;
  String? addedBy;
  String? galleryVisibility;
  String? status;
  String? gender;
  String? address;
  String? phone;
  String? createDate;
  String? updateDate;
  int? iV;
  String? familyId;

  FatherId(
      {this.sId,
      this.mainFamilyId,
      this.role,
      this.isRoot,
      this.amI,
      this.name,
      this.email,
      this.isEmailVerified,
      this.maritalStatus,
      this.spouseId,
      this.addedBy,
      this.galleryVisibility,
      this.status,
      this.gender,
      this.address,
      this.phone,
      this.createDate,
      this.updateDate,
      this.iV,
      this.familyId});

  FatherId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'];
    role = json['role'];
    isRoot = json['isRoot'];
    amI = json['amI'];
    name = json['name'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    maritalStatus = json['maritalStatus'];
    spouseId = json['spouseId'];
    addedBy = json['addedBy'];
    galleryVisibility = json['galleryVisibility'];
    status = json['status'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    familyId = json['familyId'];
  }
}

class MotherId {
  String? sId;
  String? mainFamilyId;
  String? familyId;
  String? role;
  bool? isRoot;
  bool? amI;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? status;
  String? gender;
  String? address;
  String? phone;
  String? dateOfBirth;
  String? createDate;
  String? updateDate;
  int? iV;
  String? galleryVisibility;
  String? maritalStatus;
  String? spouseId;

  MotherId(
      {this.sId,
      this.mainFamilyId,
      this.familyId,
      this.role,
      this.amI,
      this.isRoot,
      this.name,
      this.email,
      this.isEmailVerified,
      this.status,
      this.gender,
      this.address,
      this.phone,
      this.dateOfBirth,
      this.createDate,
      this.updateDate,
      this.iV,
      this.galleryVisibility,
      this.maritalStatus,
      this.spouseId});

  MotherId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'];
    familyId = json['familyId'];
    role = json['role'];
    amI = json['amI'];
    isRoot = json['isRoot'];
    name = json['name'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    status = json['status'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    dateOfBirth = json['dateOfBirth'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    galleryVisibility = json['galleryVisibility'];
    maritalStatus = json['maritalStatus'];
    spouseId = json['spouseId'];
  }
}

class MainFamilyId {
  String? sId;
  String? familyName;
  String? status;
  String? createDate;
  String? updateDate;
  int? iV;

  MainFamilyId(
      {this.sId,
      this.familyName,
      this.status,
      this.createDate,
      this.updateDate,
      this.iV});

  MainFamilyId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    familyName = json['familyName'];
    status = json['status'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }
}

class SpouseId {
  String? sId;
  String? mainFamilyId;
  String? role;
  bool? isRoot;
  bool? amI;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? maritalStatus;
  String? spouseId;
  String? addedBy;
  String? galleryVisibility;
  String? status;
  String? gender;
  String? address;
  String? phone;
  String? createDate;
  String? updateDate;
  int? iV;

  SpouseId(
      {this.sId,
      this.mainFamilyId,
      this.role,
      this.isRoot,
      this.amI,
      this.name,
      this.email,
      this.isEmailVerified,
      this.maritalStatus,
      this.spouseId,
      this.addedBy,
      this.galleryVisibility,
      this.status,
      this.gender,
      this.address,
      this.phone,
      this.createDate,
      this.updateDate,
      this.iV});

  SpouseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'];
    role = json['role'];
    isRoot = json['isRoot'];
    amI = json['amI'];
    name = json['name'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    maritalStatus = json['maritalStatus'];
    spouseId = json['spouseId'];
    addedBy = json['addedBy'];
    galleryVisibility = json['galleryVisibility'];
    status = json['status'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }
}

class Childrens {
  String? sId;
  String? mainFamilyId;
  String? familyId;
  String? role;
  bool? isRoot;
  bool? amI;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? maritalStatus;
  String? addedBy;
  String? galleryVisibility;
  String? status;
  String? gender;
  String? address;
  String? phone;
  String? fatherId;
  String? motherId;
  String? createDate;
  String? updateDate;
  int? iV;

  Childrens(
      {this.sId,
      this.mainFamilyId,
      this.familyId,
      this.role,
      this.isRoot,
      this.amI,
      this.name,
      this.email,
      this.isEmailVerified,
      this.maritalStatus,
      this.addedBy,
      this.galleryVisibility,
      this.status,
      this.gender,
      this.address,
      this.phone,
      this.fatherId,
      this.motherId,
      this.createDate,
      this.updateDate,
      this.iV});

  Childrens.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'];
    familyId = json['familyId'];
    role = json['role'];
    amI = json['amI'];
    isRoot = json['isRoot'];
    name = json['name'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    maritalStatus = json['maritalStatus'];
    addedBy = json['addedBy'];
    galleryVisibility = json['galleryVisibility'];
    status = json['status'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    fatherId = json['fatherId'];
    motherId = json['motherId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }
}
