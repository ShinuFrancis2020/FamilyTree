import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Signup extends SignupEvent {
  final String email;
  final String password;
  final String name;
  final String familyName;
  final String gender;
  final String address;
  final String phone;
  final String dateOfBirth;

  Signup({
    required this.email,required this.password,required this.name,required this.familyName,required this.gender,required this.address,required this.phone,required this.dateOfBirth,
  });
  @override
  List<Object> get props => [];
}
