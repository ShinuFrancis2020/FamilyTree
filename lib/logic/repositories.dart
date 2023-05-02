import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:family_tree_app/logic/models/commonmodel.dart';
import 'package:family_tree_app/logic/models/usermodel.dart';
import 'package:family_tree_app/server/serverhelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Repository {
  Future<UserModel> login({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await ServerHelper.post(url, data);
    final UserModel userModel = UserModel.fromJson(response);

    return userModel;
  }

  Future<CommonModel> signup({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await ServerHelper.post(url, data);
    final CommonModel userModel = CommonModel.fromJson(response);
    return userModel;
  }
}
