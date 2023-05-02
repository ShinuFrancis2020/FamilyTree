import 'package:family_tree_app/logic/bloc/signupbloc/signupevent.dart';
import 'package:family_tree_app/logic/bloc/signupbloc/signupstate.dart';
import 'package:family_tree_app/logic/models/commonmodel.dart';
import 'package:family_tree_app/logic/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(Signupinitial()) {
    on<Signup>(_signup);
  }

  Future _signup(Signup event, Emitter<SignupState> emit) async {
    emit(Signupin());
    Map data = {
      "email":event.email, "password":event.password, "name":event.name, "familyName":event.familyName,"gender":event.gender, "address":event.address, "phone":event.phone, "dateOfBirth":event.dateOfBirth
    };
    CommonModel commonModel;

    commonModel = await Repository()
        .signup(url: '/user', data: data);
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
}
