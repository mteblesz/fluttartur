import 'dart:io';
import 'package:flutter/foundation.dart';

class RtuConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5500';
    } else if (Platform.isIOS) {
      throw UnimplementedError();
    } else if (kIsWeb) {
      return 'http://localhost:5500';
    }
    return 'http://localhost:5500';
  }

  static String get url => '$baseUrl/rtu';
}
