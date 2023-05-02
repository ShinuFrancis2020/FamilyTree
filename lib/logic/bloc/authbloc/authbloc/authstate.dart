
import 'package:equatable/equatable.dart';
import 'package:family_tree_app/logic/models/usermodel.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Authinitial extends AuthState {}

class Loggingin extends AuthState {}

class Phonechecksuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class Phonechecksignup extends AuthState {
  @override
  List<Object> get props => [];
}

class PhonecheckError extends AuthState {
  final String error;
  PhonecheckError({required this.error});
  @override
  List<Object> get props => [];
}

class LoginFailed extends AuthState {
  final String error;
  LoginFailed({required this.error});
  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthState {
  final UserModel userModel;
  LoginSuccess({required this.userModel});
  @override
  List<Object> get props => [];
}

// class OTPSendSuccess extends AuthState {
//   final GenerateOtpModel generateOtpModel;
//   OTPSendSuccess({required this.generateOtpModel});
//   @override
//   List<Object> get props => [];
// }

class OTPSendFailed extends AuthState {
  final String error;
  OTPSendFailed({required this.error});
  @override
  List<Object> get props => [];
}
