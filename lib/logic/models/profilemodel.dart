class ProfileModel {
  bool? status;
  String? msg;
  Data? data;

  ProfileModel({this.status, this.msg, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? maritalStatus;
  String? sId;
  MainFamilyId? mainFamilyId;
  MainFamilyId? familyId;
  String? role;
  bool? isRoot;
  String? name;
  String? email;
  bool? isEmailVerified;
  String? status;
  String? gender;
    String? educationalQualification;
  String? currentStatus;
  String? hobbies;
  String? dateOfDeath;
  String? address;
  String? phone;
  String? dateOfBirth;
  String? createDate;
  String? updateDate;
  int? iV;

  Data(
      {this.maritalStatus,
      this.sId,
      this.mainFamilyId,
      this.familyId,
      this.role,
      this.isRoot,
        this.educationalQualification,
      this.currentStatus,
      this.hobbies,
      this.dateOfDeath,
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
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    maritalStatus = json['maritalStatus'];
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'] != null
        ? MainFamilyId.fromJson(json['mainFamilyId'])
        : null;
    familyId = json['familyId'] != null
        ? MainFamilyId.fromJson(json['familyId'])
        : null;
    role = json['role'];
    isRoot = json['isRoot'];
        educationalQualification = json['educationalQualification'];
    currentStatus = json['currentStatus'];
    hobbies = json['hobbies'];
    dateOfDeath = json['dateOfDeath'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maritalStatus'] = maritalStatus;
    data['_id'] = sId;
    if (mainFamilyId != null) {
      data['mainFamilyId'] = mainFamilyId!.toJson();
    }
    if (familyId != null) {
      data['familyId'] = familyId!.toJson();
    }
    data['role'] = role;
        data['educationalQualification'] = educationalQualification;
    data['currentStatus'] = currentStatus;
    data['hobbies'] = hobbies;
    data['dateOfDeath'] = dateOfDeath;
    data['isRoot'] = isRoot;
    data['name'] = name;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    data['status'] = status;
    data['gender'] = gender;
    data['address'] = address;
    data['phone'] = phone;
    data['dateOfBirth'] = dateOfBirth;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['familyName'] = familyName;
    data['status'] = status;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
  }
}
