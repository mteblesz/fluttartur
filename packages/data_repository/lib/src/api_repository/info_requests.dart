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

  Future<List<Player>> _getPlayerListFromUrl({required String url}) async {
    final response = await HttpSender.get(
      Uri.parse(url),
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

    List<Player> playerList =
        playerInfoList.map((info) => info.toPlayer()).toList();

    return playerList;
  }

  Future<List<Player>> getMerlinAndMorgana({required int roomId}) {
    return _getPlayerListFromUrl(url: ApiConfig.getMerlinAndMorgana(roomId));
  }

  Future<List<Player>> getEvilPlayersForMerlin({required int roomId}) {
    return _getPlayerListFromUrl(
        url: ApiConfig.getEvilPlayersForMerlinUrl(roomId));
  }

  Future<List<Player>> getEvilPlayersForEvil({required int roomId}) {
    return _getPlayerListFromUrl(
        url: ApiConfig.getEvilPlayersForEvilUrl(roomId));
  }

  Future<List<Player>> getEvilPlayers({required int roomId}) {
    return _getPlayerListFromUrl(url: ApiConfig.getEvilPlayersUrl(roomId));
  }

  Future<List<Player>> getGoodPlayers({required int roomId}) {
    return _getPlayerListFromUrl(url: ApiConfig.getGoodPlayersUrl(roomId));
  }
}
