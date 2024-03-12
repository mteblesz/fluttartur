part of 'rest_repository.dart';

extension GameRequests on RestRepository {
  Future<void> leaveGame({required int playerId}) async {
    final response = await HttpSender.delete(
      Uri.parse(RestConfig.leaveGameUrl(playerId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 204) {
      throw LeaveGameFailure(response.statusCode, response.body);
    }
  }

  Future<List<Player>> getPlayers({required int roomId}) async {
    final response = await HttpSender.get(
      Uri.parse(RestConfig.getPlayersUrl(roomId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 200) {
      throw GetPlayersListFailure(response.statusCode, response.body);
    }
    List<dynamic> jsonBody = jsonDecode(response.body);

    final playerInfoList = jsonBody.map((json) => PlayerInfoDto.fromJson(json));

    List<Player> playerList =
        playerInfoList.map((info) => info.toPlayer()).toList();

    return playerList;
  }
}
