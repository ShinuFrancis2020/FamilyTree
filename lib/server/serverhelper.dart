import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:family_tree_app/keep/localstorage.dart';
import 'package:http/http.dart' as http;

class ServerHelper {
  static const ip = 'http://192.168.52.136:5050';
  // static const ip = 'http://192.168.52.100:5050';
  // static const ip = 'http://ole.leopardtechlabs.in';
  // static const ip = 'https://api.onlineole.com';
  static const imageIp = '$ip/wp/';
  static Future<dynamic> post(url, data) async {
    var token = await LocalStorage.getToken();

    Map sendData = {};
    if (data?.isNotEmpty ?? false) {
      sendData.addAll(data);
    }
    var body = json.encode(sendData);
    dynamic response;
    try {
      response = await http
          .post(Uri.parse(ip + url),
              headers: {
                "Content-Type": "application/json",
                "token": token ?? ""
              },
              body: body)
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "Invalid Request - statusCode ${response.statusCode}"
        };
        return error;
      }
    } on Exception catch (e) {
      log('Server exception $e');
      // throw NoHostException();
    }
  }

  static Future<dynamic> get(url) async {
    try {
      var token = await LocalStorage.getToken();
      // print(token);
      var response = await http.get(
        Uri.parse(ip + url),
        headers: {"Content-Type": "application/json", "token": token ?? ""},
      );
      if (response.statusCode == 200) {
        log(response.contentLength.toString());
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "Invalid Request",
        };
        return error;
      }
    } on Exception catch (e) {
      log(e.toString());
      // throw NoHostException();
    }
  }

  static Future<dynamic> uploadFile(
      File file, String? planId, promocode, finalAmount) async {
    log("Plan ID $planId");
    try {
      String token = await LocalStorage.getToken();
      var headers = {'token': token};
      var uri = Uri.parse(
          '$ip/user/level3/buy/plan?planId=$planId&promocode=$promocode&finalAmonut=$finalAmount');
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile.fromBytes(
          'photo', file.readAsBytesSync(),
          filename: file.path);
      request.files.add(multipartFile);
      request.headers.addAll(headers);

      var response = await request.send();
      if (response.statusCode == 200) {
        log(response.contentLength.toString());
        return true;
      } else {
        // var error = {
        //   "status": false,
        //   "msg": "Invalid Request",
        // };
        return false;
      }
    } catch (e) {
      log('File upload error: $e');
    }
  }

  static Future<dynamic> uploadReciept(
      File file, String? id, bool? isadditional) async {
    try {
      String token = await LocalStorage.getToken();
      var headers = {'token': token};
      var uri = isadditional == false
          ? Uri.parse('$ip/purchase/upload/image?id=$id')
          : Uri.parse('$ip/purchase/additional/payment/upload/recipt?id=$id');
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile.fromBytes(
          'photo', file.readAsBytesSync(),
          filename: file.path);
      request.files.add(multipartFile);
      request.headers.addAll(headers);

      var response = await request.send();
      if (response.statusCode == 200) {
        log(response.contentLength.toString());
        return true;
      } else {
        // var error = {
        //   "status": false,
        //   "msg": "Invalid Request",
        // };
        return false;
      }
    } catch (e) {
      log('File upload error: $e');
    }
  }
}
