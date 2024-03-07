part of 'api_repository.dart';

extension MatchupRequests on ApiRepository {
  Future<void> createAndJoinRoom() async {
    final roomId = await _createRoom();
    await joinRoom(roomId: roomId);
  }

  Future<int> _createRoom() async {
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

  /// joins room and caches ids
  Future<void> joinRoom({required int roomId}) async {
    int playerId = await _joinRoom(roomId);

    _cache.currentPlayerId = playerId;
    _cache.currentRoomId = roomId;
  }

  /// helper method for joinRoom
  Future<int> _joinRoom(int roomId) async {
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

  Future<void> setNickname({required String nick, int? playerId}) async {
    final dto = NicknameSetDto(
      roomId: _cache.currentRoomId,
      playerId: playerId ?? _cache.currentPlayerId,
      nick: nick,
    );
    final response = await HttpSender.patch(
      Uri.parse(ApiConfig.setNicknameUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw SetNicknameFailure(response.statusCode, response.body);
    }
  }

  /// for debug reasons only, adds dummy players to server
  Future<void> addDummyPlayer({required String nick}) async {
    final playerId = await _joinRoom(_cache.currentRoomId);
    await setNickname(nick: nick, playerId: playerId);
  }

  Future<void> leaveRoom() async {
    removePlayer(removedPlayerId: _cache.currentPlayerId);
  }

  Future<void> removePlayer({required int removedPlayerId}) async {
    final response = await HttpSender.delete(
      Uri.parse(
        ApiConfig.removePlayerUrl(removedPlayerId, _cache.currentRoomId),
      ),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 204) {
      throw RemovePlayerFailure(response.statusCode, response.body);
    }
  }

  Future<void> startGame({required RolesDef rolesDef}) async {
    final dto = StartGameDto(
      roomId: _cache.currentRoomId,
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
