part of 'api_repository.dart';

extension MatchupRequests on ApiRepository {
  Future<int> createRoom() async {
    final response = await HttpSender.post(
      Uri.parse(ApiConfig.createRoomUrl()),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 201) {
      throw CreateRoomFailure(response.statusCode, response.body);
    }
    final locationHeader = response.headers[HttpHeaders.locationHeader];
    final roomId = int.parse(Uri.parse(locationHeader!).pathSegments.last);

    return roomId;
  }

  /// helper method for joinRoom
  Future<int> joinRoom({required int roomId}) async {
    final response = await HttpSender.post(
      Uri.parse(ApiConfig.joinRoomUrl(roomId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 201) {
      throw JoinRoomFailure(response.statusCode, response.body);
    }
    final locationHeader = response.headers[HttpHeaders.locationHeader];
    final playerId = int.parse(Uri.parse(locationHeader!).pathSegments.last);
    return playerId;
  }

  Future<void> setNickname({required NicknameSetDto dto}) async {
    final response = await HttpSender.patch(
      Uri.parse(ApiConfig.setNicknameUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw SetNicknameFailure(response.statusCode, response.body);
    }
  }

  Future<void> removePlayer({
    required int roomId,
    required int removedPlayerId,
  }) async {
    final response = await HttpSender.delete(
      Uri.parse(
        ApiConfig.removePlayerUrl(removedPlayerId, roomId),
      ),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 204) {
      throw RemovePlayerFailure(response.statusCode, response.body);
    }
  }

  Future<void> startGame(
      {required int roomId, required RolesDef rolesDef}) async {
    final dto = StartGameDto(
      roomId: roomId,
      areMerlinAndAssassinInGame: rolesDef.hasMerlinAndAssassin,
      arePercivalAndMorganaInGame: rolesDef.hasPercivalAndMorgana,
      areOberonAndMordredInGame: rolesDef.hasOberonAndMordred,
    );
    final response = await HttpSender.put(
      Uri.parse(ApiConfig.startGameUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw StartGameFailure(response.statusCode, response.body);
    }
  }
}
