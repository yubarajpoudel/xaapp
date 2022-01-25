import 'package:flutter/foundation.dart';

class Log {
  static d(String message, {String? tag}) {
    if(kDebugMode) {
      print("$tag, $message");
    }
  }
}