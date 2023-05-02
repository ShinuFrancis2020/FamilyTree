
import 'package:equatable/equatable.dart';
import 'package:family_tree_app/logic/models/commonmodel.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object> get props => [];
}

class  Signupinitial extends  SignupState {}
class Signupin extends SignupState {}

class SignupFailed extends  SignupState {
  final String error;
  SignupFailed({required this.error});
  @override
  List<Object> get props => [];
}

class SignupSuccess extends SignupState {

  SignupSuccess();
  @override
  List<Object> get props => [];
}

