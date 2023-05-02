import 'dart:async';

import 'package:family_tree_app/helper/helper.dart';
import 'package:family_tree_app/keep/localstorage.dart';
import 'package:family_tree_app/logic/models/commonmodel.dart';
import 'package:family_tree_app/logic/models/profilemodel.dart';
import 'package:family_tree_app/logic/models/usermodel.dart';
import 'package:family_tree_app/server/serverhelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  CommonModel loginModel = CommonModel();
  ProfileModel profileModel = ProfileModel();

  UserModel userModel = UserModel();
  // AttendanceStatusModel attendanceStatusModel = AttendanceStatusModel();
  // AttendanceList attendanceList = AttendanceList();
  String? dsvm;
  MainBloc() : super(MainState()) {
    on<DoLogin>(doLogin);
    on<GetProfile>(_getProfile);
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
        emit(LogoutSuccess(userModel: userModel));
      } else {
        Helper.showToast(msg: userModel.msg);
        emit(LoginError(error: userModel.msg.toString()));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
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
}

class MainEvent {}

class MainState {}

class CheckAuth extends MainEvent {}

class DoLogin extends MainEvent {
  final String? password, username;
  DoLogin({required this.password, required this.username});
}

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

class LogoutSuccess extends MainState {
  final UserModel userModel;
  LogoutSuccess({required this.userModel});
}

class ProfileSuccess extends MainState {
  final ProfileModel profileModel;
  ProfileSuccess({required this.profileModel});
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

class LogoutError extends MainState {
  final String error;
  LogoutError({required this.error});
}

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