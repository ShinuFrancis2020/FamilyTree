import 'dart:async';
import 'dart:developer';

import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/logic/models/commonmodel.dart';
import 'package:family_tree_app/logic/models/profiledetailedmodel.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:family_tree_app/logic/models/treemodel.dart';
import 'package:family_tree_app/logic/models/usermodel.dart';
import 'package:family_tree_app/logic/repositories.dart';
import 'package:family_tree_app/server/serverhelper.dart';
import 'package:family_tree_app/utils/initializer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  CommonModel commonModel = CommonModel();
  ProfileModel profileModel = ProfileModel();
  UserModel userModel = UserModel();

  ProfileDetailedModel profileDetailedModel = ProfileDetailedModel();
  bool? adddata = false;

  String? dsvm;
  MainBloc() : super(MainState()) {
    on<DoLogin>(doLogin);
    on<ShowGenerations>(((event, emit) {
      if (Initializer.generations.generations.length != event.index) {
        emit(UserFetched(
            treeModel: Initializer.generations.generations[event.index]));
      }
    }));

    on<GetProfile>(_getProfile);
    on<DoLogout>(doLogout);
    on<Signup>(_signup);
    on<AddFormData>(_addFormData);
    on<AddParentsData>(_addParentsData);
    on<GetUser>(getUser);
    on<GetProfileDetailed>(getProfileDetailed);
    // on<ShowNextGen>(showNextGen);

    on<GenderChanged>(
      (event, emit) => emit(GenderChangedState()),
    );
  }
  Future<FutureOr<void>> doLogin(DoLogin event, Emitter<MainState> emit) async {
    try {
      emit(Requesting());
      Map data = {
        "email": event.username,
        "password": event.password,
      };
      debugPrint(data.toString());
      userModel =
          UserModel.fromJson(await ServerHelper.post('/user/signin', data));
      if (userModel.status!) {
        await LocalStorage.setToken(userModel.token.toString());

        await LocalStorage.setUserId(userModel.uid.toString());
        emit(LoginSucces(userModel: userModel));
      } else {
        Helper.showToast(msg: userModel.msg);
        emit(LoginError(error: userModel.msg.toString()));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _signup(Signup event, Emitter<MainState> emit) async {
    emit(Signupin());
    Map data = {
      "email": event.email,
      "password": event.password,
      "name": event.name,
      "familyName": event.familyName,
      "gender": event.gender,
      "address": event.address,
      "phone": event.phone,
      "dateOfBirth": event.dateOfBirth
    };
    CommonModel commonModel;

    commonModel = await Repository().signup(url: '/user/signup', data: data);
    if (commonModel.status == true) {
      Fluttertoast.showToast(
        msg: "Registered Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(SignupSuccess());
    } else if (commonModel.status == false) {
      Fluttertoast.showToast(
        msg: commonModel.msg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(SignupFailed(error: commonModel.msg.toString()));
    }
  }

  Future<FutureOr<void>> _addFormData(
      AddFormData event, Emitter<MainState> emit) async {
    try {
      emit(AddingData());
      Map data = {
        "userId": event.uid,
        "email": event.email,
        "name": event.name,
        "familyName": event.familyName,
        "gender": event.gender == "nill" ? null : event.gender,
        "address": event.address,
        "phone": event.phone,
        "dateOfBirth": event.dateOfBirth,
        "educationalQualification": event.educationalQualification,
        "currentStatus": event.currentStatus,
        "hobbies": event.hobbies,
        "dateOfDeath": event.dateOfDeath
      };
      CommonModel commonModel;
      event.routename == "Spouse"
          ? commonModel = CommonModel.fromJson(
              await ServerHelper.post('/family/member/spouse/add', data))
          : event.editboolean == true
              ? commonModel = CommonModel.fromJson(
                  await ServerHelper.post('/user/profile/edit', data))
              : commonModel = CommonModel.fromJson(
                  await ServerHelper.post('/family/member/children/add', data));

      if (commonModel.status == true) {
        Fluttertoast.showToast(
          msg: " Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        emit(DataAddedSuccefully());
        try {
          emit(GettingUser());
          // var uId = await LocalStorage.getUserId();

          TreeModel treeModel = TreeModel.fromJson(await ServerHelper.get(
              '/user/family/members?userId=${event.uid}'));
          if (treeModel.status!) {
            Initializer.generations.generations.add(treeModel);
            emit(UserFetched(treeModel: treeModel));
          } else {
            log(treeModel.msg!);
            Helper.showToast(msg: treeModel.msg!);
            emit(UserNotFetched());
          }
        } catch (e) {
          log('fetch data : $e');
          Helper.showToast(msg: 'Unable fetch data, try again later');
          emit(GettingUserError());
        }

        try {
          emit(Fetching());

          profileModel =
              ProfileModel.fromJson(await ServerHelper.get('/user/profile'));
          if (profileModel.status!) {
            emit(ProfileSuccess(profileModel: profileModel));
          } else {
            Helper.showToast(msg: profileModel.msg);
            emit(ProfileError(error: profileModel.msg.toString()));
          }
        } catch (e) {
          emit(ProfileError(error: e.toString()));
        }
      } else if (commonModel.status == false) {
        Fluttertoast.showToast(
          msg: commonModel.msg.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        emit(DataAddedError(error: commonModel.msg.toString()));
      }
    } catch (e) {
      emit(DataAddedError(error: e.toString()));
    }
  }

  ///addparents data
  Future<FutureOr<void>> _addParentsData(
      AddParentsData event, Emitter<MainState> emit) async {
    try {
      emit(AddingData());
      Map data = {
        "userId": event.uid,
        "fatherEmail": event.fatherEmail,
        "fatherName": event.fatherName,
        "fatherAddress": event.fatherAddress,
        "fatherPhone": event.fatherPhone,
        "fatherEducationalQualification": event.fatherEducationalQualification,
        "fatherCurrentStatus": event.fatherCurrentStatus,
        "fatherHobbies": event.fatherHobbies,
        "fatherDateOfBirth": event.fatherDateOfBirth,
        "fatherDateOfDeath": event.fatherDateOfDeath,
        "motherFamilyName": event.motherFamilyName,
        "motherEmail": event.motherEmail,
        "motherName": event.motherName,
        "motherAddress": event.motherAddress,
        "motherPhone": event.motherPhone,
        "motherEducationalQualification": event.motherEducationalQualification,
        "motherCurrentStatus": event.motherCurrentStatus,
        "motherHobbies": event.motherHobbies,
        "motherDateOfBirth": event.motherDateOfBirth,
        "motherDateOfDeath": event.motherDateOfDeath,
      };
      print(data);
      CommonModel commonModel;
      commonModel = CommonModel.fromJson(
          await ServerHelper.post('/family/member/parents/add', data));

      if (commonModel.status == true) {
        Fluttertoast.showToast(
          msg: " Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        emit(DataAddedSuccefully());

        try {
          emit(GettingUser());
          // var uId = await LocalStorage.getUserId();

          TreeModel treeModel = TreeModel.fromJson(await ServerHelper.get(
              '/user/family/members?userId=${event.uid}'));
          if (treeModel.status!) {
            Initializer.generations.generations.add(treeModel);
            emit(UserFetched(treeModel: treeModel));
          } else {
            log(treeModel.msg!);
            Helper.showToast(msg: treeModel.msg!);
            emit(UserNotFetched());
          }
        } catch (e) {
          log('fetch data : $e');
          Helper.showToast(msg: 'Unable fetch data, try again later');
          emit(GettingUserError());
        }
      } else if (commonModel.status == false) {
        Fluttertoast.showToast(
          msg: commonModel.msg.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        emit(DataAddedError(error: commonModel.msg.toString()));
      }
    } catch (e) {
      emit(DataAddedError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> getProfileDetailed(
      GetProfileDetailed event, Emitter<MainState> emit) async {
    try {
      emit(ProfileDetailedLoding());

      profileDetailedModel = ProfileDetailedModel.fromJson(
          await ServerHelper.get(
              '/user/family/member/details?userId=${event.userID}'));
      if (profileDetailedModel.status!) {
        emit(
            ProfileDetailedSuccess(profileDetailedModel: profileDetailedModel));
      } else {
        Helper.showToast(msg: profileModel.msg);
        emit(ProfileDetailedError(error: profileDetailedModel.msg.toString()));
      }
    } catch (e) {
      emit(ProfileDetailedError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _getProfile(
      GetProfile event, Emitter<MainState> emit) async {
    try {
      emit(Fetching());

      profileModel =
          ProfileModel.fromJson(await ServerHelper.get('/user/profile'));
      if (profileModel.status!) {
        emit(ProfileSuccess(profileModel: profileModel));
      } else {
        Helper.showToast(msg: profileModel.msg);
        emit(ProfileError(error: profileModel.msg.toString()));
      }
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> doLogout(
      DoLogout event, Emitter<MainState> emit) async {
    try {
      emit(Loggingout());

      commonModel =
          CommonModel.fromJson(await ServerHelper.get('/user/logout'));
      if (commonModel.status!) {
        emit(LogouSuccess());
      } else {
        Helper.showToast(msg: commonModel.msg);
        emit(LogoutError(error: profileModel.msg.toString()));
      }
    } catch (e) {
      emit(LogoutError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> getUser(GetUser event, Emitter<MainState> emit) async {
    try {
      emit(GettingUser());
      var uId = await LocalStorage.getUserId();

      TreeModel treeModel = TreeModel.fromJson(await ServerHelper.get(
          '/user/family/members?userId=${event.userID == "nill" ? uId : event.userID}'));
      if (treeModel.status!) {
        Initializer.generations.generations.add(treeModel);
        emit(UserFetched(treeModel: treeModel));
      } else {
        log(treeModel.msg!);
        Helper.showToast(msg: treeModel.msg!);
        emit(UserNotFetched());
      }
    } catch (e) {
      log('fetch data : $e');
      Helper.showToast(msg: 'Unable fetch data, try again later');
      emit(GettingUserError());
    }
  }

  Future<FutureOr<void>> showNextGen(
      ShowNextGen event, Emitter<MainState> emit) async {
    try {
      emit(ShowingNextGen());
      // var uId = await LocalStorage.getUserId();
      TreeModel treeModel = TreeModel.fromJson(await ServerHelper.get(
          '/user/family/members?userId=6450b84dd476264984b74249'));
      if (treeModel.status!) {
        emit(NextGenVisible());
      } else {
        log(treeModel.msg!);
        Helper.showToast(msg: treeModel.msg!);
        emit(NextGenNotVisible());
      }
    } catch (e) {
      log('fetch data : e');
      Helper.showToast(msg: 'Unable fetch data, try again later');
      emit(ShowingNextGenError());
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MainEvent {}

class MainState {}

class CheckAuth extends MainEvent {}

class DoLogin extends MainEvent {
  final String? password, username;
  DoLogin({required this.password, required this.username});
}

class Signup extends MainEvent {
  final String email;
  final String password;
  final String name;
  final String familyName;
  final String gender;
  final String address;
  final String phone;
  final String dateOfBirth;

  Signup({
    required this.email,
    required this.password,
    required this.name,
    required this.familyName,
    required this.gender,
    required this.address,
    required this.phone,
    required this.dateOfBirth,
  });
}

class AddFormData extends MainEvent {
  final String email, uid, routename;
  final String password;
  final bool? editboolean;
  final String name;
  final String familyName;
  final String gender;
  final String address;
  final String phone;
  final String dateOfBirth;

  final String educationalQualification;
  final String currentStatus;
  final String hobbies;
  final String dateOfDeath;

  AddFormData({
    required this.email,
    required this.editboolean,
    required this.routename,
    required this.uid,
    required this.password,
    required this.name,
    required this.familyName,
    required this.gender,
    required this.address,
    required this.phone,
    required this.dateOfBirth,
    required this.educationalQualification,
    required this.currentStatus,
    required this.hobbies,
    required this.dateOfDeath,
  });
}

class AddParentsData extends MainEvent {
  final String? fatherEmail, uid, fatherName;
  final String? fatherAddress;
  final String? fatherPhone;
  final String? fatherCurrentStatus;
  final String? fatherEducationalQualification;
  final String? fatherHobbies;
  final String? fatherDateOfBirth;
  final String? fatherDateOfDeath;
  final String? motherFamilyName,
      motherEmail,
      motherName,
      motherAddress,
      motherPhone,
      motherEducationalQualification,
      motherCurrentStatus,
      motherHobbies,
      motherDateOfBirth,
      motherDateOfDeath;
  AddParentsData({
    this.fatherEmail,
    this.fatherName,
    this.uid,
    this.fatherAddress,
    this.fatherPhone,
    this.fatherCurrentStatus,
    this.fatherEducationalQualification,
    this.fatherHobbies,
    this.fatherDateOfBirth,
    this.fatherDateOfDeath,
    this.motherFamilyName,
    this.motherEmail,
    this.motherName,
    this.motherAddress,
    this.motherPhone,
    this.motherEducationalQualification,
    this.motherCurrentStatus,
    this.motherHobbies,
    this.motherDateOfBirth,
    this.motherDateOfDeath,
  });
}

class DoLogout extends MainEvent {}

class GetProfile extends MainEvent {
  // final String? password, username;
  // GetProfile({required this.password, required this.username});
}

class GetLogoutEvent extends MainEvent {
  final String? password, count;
  final String? phone;
  GetLogoutEvent({this.count, this.password, this.phone});
}

class Requesting extends MainState {}

class Signupin extends MainState {}

class AddingData extends MainState {}

class Fetching extends MainState {}

class Loggingout extends MainState {}

class LoginSuccess extends MainState {
  final CommonModel loginModel;
  LoginSuccess({required this.loginModel});
}

class AdminLoginSuccess extends MainState {
  final CommonModel loginModel;
  AdminLoginSuccess({required this.loginModel});
}

class SignupFailed extends MainState {
  final String error;
  SignupFailed({required this.error});
  List<Object> get props => [];
}

class DataAddedError extends MainState {
  final String error;
  DataAddedError({required this.error});
  List<Object> get props => [];
}

class SignupSuccess extends MainState {
  SignupSuccess();
  // @override
  // List<Object> get props => [];
}

class DataAddedSuccefully extends MainState {
  DataAddedSuccefully();
  // @override
  // List<Object> get props => [];
}

class LoginSucces extends MainState {
  final UserModel userModel;
  LoginSucces({required this.userModel});
}

class ProfileSuccess extends MainState {
  final ProfileModel profileModel;
  ProfileSuccess({required this.profileModel});
}

class ProfileDetailedSuccess extends MainState {
  final ProfileDetailedModel profileDetailedModel;
  ProfileDetailedSuccess({required this.profileDetailedModel});
}

class EmployeeLoginSuccess extends MainState {
  final CommonModel loginModel;
  EmployeeLoginSuccess({required this.loginModel});
}

class ClientLoginSuccess extends MainState {
  final CommonModel loginModel;
  ClientLoginSuccess({required this.loginModel});
}

class LoginError extends MainState {
  final String error;
  LoginError({required this.error});
}

class ProfileError extends MainState {
  final String error;
  ProfileError({required this.error});
}

class ProfileDetailedError extends MainState {
  final String error;
  ProfileDetailedError({required this.error});
}

class LogoutSucces extends MainState {}

class LogoutError extends MainState {
  final String error;
  LogoutError({required this.error});
}

class LogouSuccess extends MainState {}

class ProfileDetailedLoding extends MainState {}

class AddUserContactMatchList extends MainState {
  final CommonModel loginModel;
  AddUserContactMatchList({required this.loginModel});
}

class CheckAttendanceStatus extends MainEvent {}

class CheckingAttendanceStatus extends MainState {}

class AttendancePunchedIN extends MainState {}

class AttendancePunchedOUT extends MainState {}

class AttendanceNotMarked extends MainState {}

class AttendanceAlreadyMarked extends MainState {}

class AttendanceStatusNotChecked extends MainState {}

class CheckingAttendanceStatusError extends MainState {}

class GenderChanged extends MainEvent {}

//GetAttendanceHistory

class GetAttendanceHistory extends MainEvent {
  final String? firstDate, lastDate;
  GetAttendanceHistory({required this.firstDate, required this.lastDate});
}

class GettingAttendanceHistory extends MainState {}

class AttendanceHistoryFetched extends MainState {
  final CommonModel? attendanceList;
  AttendanceHistoryFetched({required this.attendanceList});
}

class AttendaceEmpty extends MainState {}

class AttendanceHistoryNotFetched extends MainState {}

class GettingAttendanceHistoryError extends MainState {}

class MarkAttendance extends MainEvent {
  final String? type;
  MarkAttendance({required this.type});
}

class MarkingAttendance extends MainState {}

class AttendanceMarked extends MainState {}

class MarkingFailed extends MainState {}

class MarkingFailedError extends MainState {}

//

class GetFamily extends MainEvent {}

class GettingFamily extends MainState {}

class FamilySuccess extends MainState {}

class FamilyFailed extends MainState {}

class FamilyErorr extends MainState {}

class GenderChangedState extends MainState {}

//

class GetUser extends MainEvent {
  final String? userID;
  GetUser({this.userID});
}

class GetProfileDetailed extends MainEvent {
  final String? userID;
  GetProfileDetailed({this.userID});
}

class GettingUser extends MainState {}

class UserFetched extends MainState {
  final TreeModel treeModel;
  UserFetched({required this.treeModel});
}

class UserNotFetched extends MainState {}

class GettingUserError extends MainState {}

//to view next generation

class ShowNextGen extends MainEvent {}

class ShowingNextGen extends MainState {}

class NextGenVisible extends MainState {}

class NextGenNotVisible extends MainState {}

class ShowingNextGenError extends MainState {}

class ShowGenerations extends MainEvent {
  final int index;
  ShowGenerations({required this.index});
}

class ShowingGeneration extends MainState {}
