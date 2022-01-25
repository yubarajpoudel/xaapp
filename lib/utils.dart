import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class Log {
  static d(String message, {String? tag}) {
    if(kDebugMode) {
      print("${tag??"XAApp"}, $message");
    }
  }
}

class Utils {
  static toast(String message, {Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static Future<bool?> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }
}