import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'https://10.0.2.2:7700';
    } else if (Platform.isIOS) {
      throw UnimplementedError();
    } else if (kIsWeb) {
      return 'https://localhost:7700';
    }
    return 'https://localhost:7700';
  }

  static String get apiUrl => '$baseUrl/api';

  static String createRoomUrl() => '$apiUrl/matchup/room';
  static String joinRoomUrl(int id) => '$apiUrl/matchup/join/$id';
  static String setNicknameUrl() => '$apiUrl/matchup/nick';
  static String removePlayerUrl() => '$apiUrl/matchup/remove';
  static String startGameUrl() => '$apiUrl/matchup/start';

  static String getRoomByIdUrl(int id) => '$apiUrl/info/room/$id';
  static String getPlayerByIdUrl(int id) => '$apiUrl/info/player/$id';
  static String getGoodPlayersUrl(int id) => '$apiUrl/info/goodplayers/$id';
  static String getEvilPlayersUrl(int id) => '$apiUrl/info/evilplayers/$id';
  static String getQuestBySquadIdUrl(int id) => '$apiUrl/info/quest/$id';

  static String addMemberUrl(int id) => '$apiUrl/squad/add/$id';
  static String removeMemberUrl(int id) => '$apiUrl/squad/remove/$id';
  static String submitSquadUrl(int id) => '$apiUrl/squad/submit/$id';

  static String voteSquadUrl() => '$apiUrl/vote/squad';
  static String voteQuestUrl() => '$apiUrl/vote/quest';

  static String killPlayerUrl(int id) => '$apiUrl/kill/$id';
}
