// ignore_for_file: non_constant_identifier_names

import 'package:universal_io/io.dart';
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

  // SignalR Hub channels
  static String get JoinRoomGroup => "JoinRoomGroup";
  static String get ReceivePlayerList => "ReceivePlayerList";
  static String get ReceiveRemoval => "ReceiveRemoval";
  static String get ReceiveStartGame => "ReceiveStartGame";
  static String get ReceiveCurrentSquad => "ReceiveCurrentSquad";
  static String get ReceiveQuestsSummary => "ReceiveSquadsSummary";
  static String get ReceivePlayerLeft => "ReceivePlayerLeft";
}
