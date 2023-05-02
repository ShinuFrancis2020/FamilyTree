
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
  @override
  List<Object> get props => [];
}

class GenerateOtp extends AuthEvent {
  final String phoneNumber;

  GenerateOtp({required this.phoneNumber});
  @override
  List<Object> get props => [];
}

class LoginWithOtp extends AuthEvent {
  final String phoneNumber, otp;

  LoginWithOtp({required this.phoneNumber, required this.otp});
  @override
  List<Object> get props => [];
}
