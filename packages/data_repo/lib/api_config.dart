class ApiConfig {
  static const String baseUrl = 'https://localhost:7146/api/';
  static String createRoomUrl() => "${baseUrl}Matchup/";
  static String getRoomByIdUrl(int id) => "${baseUrl}Matchup/$id/";
  static String createPlayerUrl() => "${baseUrl}Matchup/player/";
  static String removePlayerUrl(int id) => "${baseUrl}Matchup/player/$id/";
  static String startGameUrl() => "${baseUrl}Matchup/StartGame/";
}
