import 'dart:async';

import 'package:cache/cache.dart';
import 'package:data_repository/model/model.dart';
import 'dtos/dtos.dart';
import 'package:data_repository/src/rest_repository/rest_repository.dart';
import 'package:data_repository/src/realtime_repository/rtu_repository.dart';
import 'package:data_repository/src/data_cache.dart';

/// Facade for classess communicating with api
class DataRepository implements IDataRepository {
  DataRepository({
    CacheClient? cacheClient,
  }) {
    _cache = DataCache(cacheClient ?? CacheClient());
    _restRepository = RestRepository(getAuthToken: () => _cache.authToken);
    _rtuRepository = RtuRepository();
  }
  late DataCache _cache;
  late RestRepository _restRepository;
  late RtuRepository _rtuRepository;

  //----------------------- info -----------------------
  @override
  int get currentRoomId => _cache.currentRoomId;

  //----------------------- matchup -----------------------
  @override
  Future<void> createAndJoinRoom() async {
    final roomId = await _restRepository.createRoom();
    await joinRoom(roomId: roomId);
  }

  @override
  Future<void> joinRoom({required int roomId}) async {
    try {
      await _rtuRepository.connect(roomId: roomId);
      _rtuRepository.subscribePlayersList();
      int playerId = await _restRepository.joinRoom(roomId: roomId);
      _cache.currentPlayerId = playerId;
      _cache.currentRoomId = roomId;
    } on Exception catch (_) {
      _rtuRepository.unsubscribePlayersList();
      _rtuRepository.dispose();
    }
  }

  @override
  Future<void> setNickname({required String nick}) async {
    await _restRepository.setNickname(
        dto: NicknameSetDto(
      roomId: _cache.currentRoomId,
      playerId: _cache.currentPlayerId,
      nick: nick,
    ));
  }

  @override
  Future<void> addDummyPlayer({required String nick}) async {
    int playerId = await _restRepository.joinRoom(roomId: _cache.currentRoomId);
    await _restRepository.setNickname(
      dto: NicknameSetDto(
        roomId: _cache.currentRoomId,
        playerId: playerId,
        nick: nick,
      ),
    );
  }

  @override
  Stream<List<Player>> streamPlayersList() => _rtuRepository.playerStream;

  @override
  Future<void> leaveMatchup() async {
    _rtuRepository.unsubscribePlayersList();
    _rtuRepository.dispose();
    await _restRepository.removePlayer(
      roomId: _cache.currentRoomId,
      removedPlayerId: _cache.currentPlayerId,
    );
  }

  @override
  Future<void> removePlayer({required int playerId}) async {
    await _restRepository.removePlayer(
      roomId: _cache.currentRoomId,
      removedPlayerId: playerId,
    );
  }

  @override
  void handlePlayerRemoval({required void Function() handler}) {
    _rtuRepository.handlePlayerRemoval(
      currentPlayerId: _cache.currentPlayerId,
      removalHandler: handler,
    );
  }

  @override
  Future<void> startGame({required RolesDef rolesDef}) async {
    await _restRepository.startGame(
      roomId: _cache.currentRoomId,
      rolesDef: rolesDef,
    );
  }

  @override
  void handleGameStarted({required void Function() handler}) {
    _rtuRepository.handleGameStarted(startGameHandler: () async {
      _rtuRepository.subscribeQuestsSummary();
      _rtuRepository.subscribeCurrentSquad();
      _rtuRepository.subscribeEndGameInfo();
      await _fetchTeamRole();
      handler();
    });
  }

  @override
  Future<void> leaveGame() async {
    _rtuRepository.unsubscribePlayersList();
    _rtuRepository.unsubscribeQuestsSummary();
    _rtuRepository.unsubscribeCurrentSquad();
    _rtuRepository.unsubscribeEndGameInfo();
    _rtuRepository.dispose();
    await _restRepository.leaveGame(
      playerId: _cache.currentPlayerId,
    );
  }

//------------------------------ game init -------------------------------------

  Future<void> _fetchTeamRole() async {
    final playerId = _cache.currentPlayerId;
    _cache.currentTeamRole =
        await _restRepository.getRoleByPlayerId(playerId: playerId);
  }

  @override
  TeamRole get currentTeamRole => _cache.currentTeamRole;

  @override
  Future<List<Player>> getMerlinAndMorgana() {
    return _restRepository.getMerlinAndMorgana(roomId: _cache.currentRoomId);
  }

  @override
  Future<List<Player>> getEvilPlayersForMerlin() {
    return _restRepository.getEvilPlayersForMerlin(
        roomId: _cache.currentRoomId);
  }

  @override
  Future<List<Player>> getEvilPlayersForEvil() {
    return _restRepository.getEvilPlayersForEvil(roomId: _cache.currentRoomId);
  }

  @override
  Future<List<Player>> getEvilPlayers() {
    return _restRepository.getEvilPlayers(roomId: _cache.currentRoomId);
  }

  @override
  Future<List<Player>> getGoodPlayers() {
    return _restRepository.getGoodPlayers(roomId: _cache.currentRoomId);
  }

//------------------------------ game misc -------------------------------------

  @override
  Future<List<Player>> getPlayers() {
    return _restRepository.getPlayers(roomId: _cache.currentRoomId);
  }

  @override
  void handlePlayerLeftGame({
    required void Function(Player) handler,
  }) {
    _rtuRepository.handlePlayerLeftGame(playerLeftHandler: handler);
  }

//------------------------------ squad/quest info ------------------------------
  @override
  Stream<Squad> streamCurrentSquad() => _rtuRepository.currentSquadStream;

  @override
  Stream<List<QuestInfoShort>> streamQuestsSummary() =>
      _rtuRepository.questsSummaryStream;

  @override
  Future<QuestInfo> getQuestInfo({required int squadId}) {
    return _restRepository.getQuestInfo(squadId: squadId);
  }

//--------------------------------- Court --------------------------------------

  @override
  int get currentPlayerId => _cache.currentPlayerId;

  @override
  Future<void> addMember({required int playerId}) async {
    await _restRepository.addMember(playerId: playerId);
  }

  @override
  Future<void> removeMember({required int playerIdOfMember}) async {
    await _restRepository.removeMember(playerId: playerIdOfMember);
  }

  @override
  Future<void> submitSquad({required int squadId}) async {
    await _restRepository.submitSquad(squadId: squadId);
  }

  @override
  Future<void> voteSquad({required bool vote, required int squadId}) async {
    await _restRepository.voteSquad(
      dto: CastVoteDto(
        value: vote,
        squadId: squadId,
        voterId: _cache.currentPlayerId,
      ),
    );
  }

  @override
  Future<void> voteQuest({required bool vote, required int squadId}) async {
    await _restRepository.voteQuest(
      dto: CastVoteDto(
        value: vote,
        squadId: squadId,
        voterId: _cache.currentPlayerId,
      ),
    );
  }

//--------------------------------- End Game -----------------------------------

  @override
  Stream<RoomStatus> streamEndGameInfo() => _rtuRepository.endGameInfoStream;

  @override
  Future<void> killPlayer({required int targetId}) async {
    await _restRepository.killPlayer(
      dto: KillPlayerDto(
        roomId: _cache.currentRoomId,
        assassinId: _cache.currentPlayerId,
        targetId: targetId,
      ),
    );
  }
}
