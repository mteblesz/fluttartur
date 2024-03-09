part of 'api_repository.dart';

extension InfoRequests on ApiRepository {
  Future<Room> getRoomById({required int roomId}) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getRoomByIdUrl(roomId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(response.statusCode, response.body);
    }
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return RoomInfoDto.fromJson(jsonBody).toRoom();
  }

  Future<TeamRole> getRoleByPlayerId({required int playerId}) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getRoleByPlayerIdUrl(playerId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(response.statusCode, response.body);
    }
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    final String teamStr = jsonBody["team"] as String;
    final String roleStr = jsonBody["role"] as String;
    final Team team = Team.values.byName(teamStr.toLowerFirst());
    final Role role = Role.values.byName(roleStr.toLowerFirst());
    return TeamRole(team, role);
  }

  Future<List<Player>> getEvilPlayers({required int roomId}) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getEvilPlayersUrl(roomId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(response.statusCode, response.body);
    }
    List<dynamic> jsonBody = jsonDecode(response.body);

    List<PlayerInfoDto> playerInfoList = jsonBody
        .map((json) => PlayerInfoDto.fromJson(json as Map<String, dynamic>))
        .toList();

    List<Player> playerList =
        playerInfoList.map((info) => info.toPLayer()).toList();

    return playerList;
  }

  Future<List<Player>> getMerlinAndMorgana({required int roomId}) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getMerlinAndMorgana(roomId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(
          response.statusCode, response.body); // TODO add propper exceptions
    }

    List<dynamic> jsonBody = jsonDecode(response.body);

    List<PlayerInfoDto> playerInfoList = jsonBody
        .map((json) => PlayerInfoDto.fromJson(json as Map<String, dynamic>))
        .toList();

    List<Player> merlinAndMorgana =
        playerInfoList.map((info) => info.toPLayer()).toList();

    return merlinAndMorgana;
  }
}
