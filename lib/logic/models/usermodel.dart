class UserModel {
  bool? status;
  String? msg;
  String? token;
  String? uid;
  String? role;
  Data? data;

  UserModel(
      {this.status, this.msg, this.token, this.uid, this.role, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    token = json['token'];
    uid = json['uid'];
    role = json['role'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['token'] = token;
    data['uid'] = uid;
    data['role'] = role;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? mainFamilyId;
  String? familyId;
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

  Data(
      {this.sId,
      this.mainFamilyId,
      this.familyId,
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
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainFamilyId = json['mainFamilyId'];
    familyId = json['familyId'];
    role = json['role'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mainFamilyId'] = mainFamilyId;
    data['familyId'] = familyId;
    data['role'] = role;
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