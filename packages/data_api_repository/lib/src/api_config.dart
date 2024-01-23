class ApiConfig {
  static const String baseUrl = 'https://10.0.2.2:7146/api';

  static String createRoomUrl() => '$baseUrl/matchup/room';
  static String joinRoomUrl(int id) => '$baseUrl/matchup/join/$id';
  static String setNicknameUrl() => '$baseUrl/matchup/nick';
  static String removePlayerUrl(int id) => '$baseUrl/matchup/remove/$id';
  static String startGameUrl() => '$baseUrl/matchup/start';

  static String getRoomByIdUrl(int id) => '$baseUrl/info/room/$id';
  static String getPlayerByIdUrl(int id) => '$baseUrl/info/player/$id';
  static String getGoodPlayersUrl(int id) => '$baseUrl/info/goodplayers/$id';
  static String getEvilPlayersUrl(int id) => '$baseUrl/info/evilplayers/$id';
  static String getQuestBySquadIdUrl(int id) => '$baseUrl/info/quest/$id';

  static String addMemberUrl(int id) => '$baseUrl/squad/add/$id';
  static String removeMemberUrl(int id) => '$baseUrl/squad/remove/$id';
  static String submitSquadUrl(int id) => '$baseUrl/squad/submit/$id';

  static String voteSquadUrl() => '$baseUrl/vote/squad';
  static String voteQuestUrl() => '$baseUrl/vote/quest';

  static String killPlayerUrl(int id) => '$baseUrl/kill/$id';
}
