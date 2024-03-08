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

    final String teamStr = jsonBody["Team"] as String;
    final String roleStr = jsonBody["Role"] as String;
    final Team team = Team.values.byName(teamStr.toLowerFirst());
    final Role role = Role.values.byName(roleStr.toLowerFirst());
    return TeamRole(team, role);
  }
}
