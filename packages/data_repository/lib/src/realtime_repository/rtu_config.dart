import 'dart:io';
import 'package:flutter/foundation.dart';

class RtuConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return '10.0.2.2:7146';
    } else if (Platform.isIOS) {
      throw UnimplementedError();
    } else if (kIsWeb) {
      return 'localhost:7146';
    }
    return 'localhost:7146';
  }

  static String get url => '$baseUrl/rtu';
}
