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
      subscribePlayersList();
      int playerId = await _restRepository.joinRoom(roomId: roomId);
      _cache.currentPlayerId = playerId;
      _cache.currentRoomId = roomId;
    } on Exception catch (_) {
      unsubscribePlayersList();
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
    ));
  }

  @override
  Stream<List<Player>> streamPlayersList() => _rtuRepository.playerStream;
  // TODO jak stream pusty to api call o info,
  // albo najpirw dodawac do streama po api callu a potem subskryowac,
  // albo na serwerze kolejnosc cos nie cos?
  @override
  void subscribePlayersList() => _rtuRepository.subscribePlayersList();
  @override
  void unsubscribePlayersList() => _rtuRepository.unsubscribePlayersList();

  @override
  Future<void> leaveMatchup() async {
    unsubscribePlayersList();
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
      subscribeQuestsSummary();
      subscribeCurrentSquad();
      await _fetchTeamRole();
      handler();
    });
  }

  @override
  Future<void> leaveGame() async {
    unsubscribePlayersList();
    unsubscribeQuestsSummary();
    unsubscribeCurrentSquad();
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

  // TODO it this needed?
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

//------------------------------ squad/quest info -------------------------------------
  @override
  Stream<Squad> streamCurrentSquad() => _rtuRepository.currentSquadStream;
  @override
  void subscribeCurrentSquad() => _rtuRepository.subscribeCurrentSquad();
  @override
  void unsubscribeCurrentSquad() => _rtuRepository.unsubscribeCurrentSquad();

  @override
  Stream<List<QuestInfoShort>> streamQuestsSummary() =>
      _rtuRepository.questsSummaryStream;
  @override
  void subscribeQuestsSummary() => _rtuRepository.subscribeQuestsSummary();
  @override
  void unsubscribeQuestsSummary() => _rtuRepository.unsubscribeQuestsSummary();

  @override
  Future<QuestInfo> getQuestInfo({required int squadId}) {
    return _restRepository.getQuestInfo(squadId: squadId);
  }

//----------------------------------------------------------------------------

  @override
  Stream<List<Player>> streamMembersList() {
    return streamPlayersList(); // TODO
  }
//----------------------------------------------------------------------------

  // ----------------------------------------------------------------------
  //  old stuff for backwards-compatibility during changes (to be removed)

  @override
  Future<void> addMember(
      {required int questNumber, required int playerId, required String nick}) {
    // : implement addMember
    throw UnimplementedError();
  }

  @override
  Future<bool> isCurrentPlayerAMember() {
    // : implement isCurrentPlayerAMember
    throw UnimplementedError();
  }

  @override
  Future<void> removeMember({required int questNumber, required int memberId}) {
    // : implement removeMember
    throw UnimplementedError();
  }

  @override
  Stream<bool?> streamMerlinKilled() {
    // : implement streamMerlinKilled
    throw UnimplementedError();
  }

  @override
  Future<void> submitSquad() {
    // : implement submitSquad
    throw UnimplementedError();
  }

  @override
  Future<void> updateMerlinKilled(bool merlinKilled) {
    // : implement updateMerlinKilled
    throw UnimplementedError();
  }

  @override
  Future<void> voteQuest(bool vote) {
    // : implement voteQuest
    throw UnimplementedError();
  }

  @override
  voteSquad(bool vote) {
    // : implement voteSquad
    throw UnimplementedError();
  }
}
