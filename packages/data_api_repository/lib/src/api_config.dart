class ApiConfig {
  static const String baseUrl = 'https://10.0.2.2:7146';
  static String createRoomUrl() => "$baseUrl/room/";
  static String getRoomByIdUrl(int id) => "$baseUrl/room/$id/";
  static String createPlayerUrl() => "$baseUrl/player/";
  static String removePlayerUrl(int id) => "$baseUrl/player/$id/";
  static String startGameUrl() => "$baseUrl/start/";
}
