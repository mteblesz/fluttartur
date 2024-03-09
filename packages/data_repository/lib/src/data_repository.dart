import 'dart:async';

import 'package:cache/cache.dart';
import 'package:data_repository/model/model.dart';
import 'dtos/dtos.dart';
import 'package:data_repository/src/api_repository/api_repository.dart';
import 'package:data_repository/src/realtime_repository/rtu_repository.dart';
import 'package:data_repository/src/data_cache.dart';

/// Facade for classess communicating with api
class DataRepository implements IDataRepository {
  DataRepository({
    CacheClient? cacheClient,
  }) {
    _cache = DataCache(cacheClient ?? CacheClient());
    _apiRepository = ApiRepository(getAuthToken: () => _cache.authToken);
    _rtuRepository = RtuRepository();
  }
  late DataCache _cache;
  late ApiRepository _apiRepository;
  late RtuRepository _rtuRepository;

  //----------------------- info -----------------------
  @override
  int get currentRoomId => _cache.currentRoomId;

  //----------------------- matchup -----------------------
  @override
  Future<void> createAndJoinRoom() async {
    try {
      final roomId = await _apiRepository.createRoom();
      final playerId = await _apiRepository.joinRoom(roomId: roomId);
      _cache.currentPlayerId = playerId;
      _cache.currentRoomId = roomId;
      await _rtuRepository.connect(roomId: roomId);
    } on Exception catch (_) {
      _rtuRepository.dispose();
    }
  }

  @override
  Future<void> joinRoom({required int roomId}) async {
    try {
      int playerId = await _apiRepository.joinRoom(roomId: roomId);
      _cache.currentPlayerId = playerId;
      _cache.currentRoomId = roomId;
      await _rtuRepository.connect(roomId: roomId);
    } on Exception catch (_) {
      _rtuRepository.dispose();
    }
  }

  @override
  Future<void> setNickname({required String nick}) async {
    await _apiRepository.setNickname(
        dto: NicknameSetDto(
      roomId: _cache.currentRoomId,
      playerId: _cache.currentPlayerId,
      nick: nick,
    ));
  }

  @override
  Future<void> addDummyPlayer({required String nick}) async {
    int playerId = await _apiRepository.joinRoom(roomId: _cache.currentRoomId);
    await _apiRepository.setNickname(
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
  Future<void> leaveRoom() async {
    await _apiRepository.removePlayer(
      roomId: _cache.currentRoomId,
      removedPlayerId: _cache.currentPlayerId,
    );
  }

  @override
  Future<void> removePlayer({required int playerId}) async {
    await _apiRepository.removePlayer(
      roomId: _cache.currentRoomId,
      removedPlayerId: playerId,
    );
  }

  @override
  void handlePlayerRemoval({required void Function() handler}) {
    _rtuRepository.handlePlayerRemoval(
      playerId: _cache.currentPlayerId,
      removalHandler: handler,
    );
  }

  @override
  Future<void> startGame({required RolesDef rolesDef}) async {
    await _apiRepository.startGame(
      roomId: _cache.currentRoomId,
      rolesDef: rolesDef,
    );
  }

  @override
  void handleGameStarted({required void Function() handler}) {
    _rtuRepository.handleGameStarted(startGameHandler: () async {
      await _fetchTeamRole();
      handler();
    });
  }

//------------------------------ game -----------------------------------------

  Future<void> _fetchTeamRole() async {
    final playerId = _cache.currentPlayerId;
    _cache.currentTeamRole =
        await _apiRepository.getRoleByPlayerId(playerId: playerId);
  }

  @override
  TeamRole get currentTeamRole => _cache.currentTeamRole;

  @override
  Future<List<Player>> getEvilPlayers() {
    return _apiRepository.getEvilPlayers(roomId: _cache.currentRoomId);
  }

  @override
  Future<List<Player>> getMerlinAndMorgana() {
    return _apiRepository.getMerlinAndMorgana(roomId: _cache.currentRoomId);
  }

//----------------------------------------------------------------------------

  @override
  Stream<List<Player>> streamMembersList() {
    return streamPlayersList(); // TODO
  }
//----------------------------------------------------------------------------

  @override
  Future<List<Player>> playersList() {
    // : implement playersList
    throw UnimplementedError();
  }

  // ----------------------------------------------------------------------
  //  old stuff for backwards-compatibility during changes (to be removed)

  @override
  String currentSquadId = "";

  @override
  Future<void> addMember(
      {required int questNumber,
      required String playerId,
      required String nick}) {
    // : implement addMember
    throw UnimplementedError();
  }

  @override
  // : implement currentPlayer
  Player get currentPlayer => throw UnimplementedError();

  @override
  Future<List<Squad>> getApprovedSquads() {
    // : implement getApprovedSquads
    throw UnimplementedError();
  }

  @override
  Future<bool> isCurrentPlayerAMember() {
    // : implement isCurrentPlayerAMember
    throw UnimplementedError();
  }

  @override
  Future<void> nextSquad({required int questNumber}) {
    // : implement nextSquad
    throw UnimplementedError();
  }

  @override
  Future<List<bool>> questVotesInfo(int questNumber) {
    // : implement questVotesInfo
    throw UnimplementedError();
  }

  @override
  Future<void> removeMember(
      {required int questNumber, required String memberId}) {
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
  void subscribeCurrentSquadIdWith(
      {required void Function(String p1) doLogic}) {
    // : implement subscribeCurrentSquadIdWith
  }

  @override
  void subscribeQuestVotesWith(
      {required void Function(List<bool?> p1) doLogic}) {
    // : implement subscribeQuestVotesWith
  }

  @override
  void subscribeSquadIsSubmittedWith(
      {String squadId = '', required void Function(Squad p1) doLogic}) {
    // : implement subscribeSquadIsSubmittedWith
  }

  @override
  void subscribeSquadVotesWith(
      {required void Function(Map<String, bool> p1) doLogic}) {
    // : implement subscribeSquadVotesWith
  }

  @override
  void unsubscribeCurrentSquadId() {
    // : implement unsubscribeCurrentSquadId
  }

  @override
  void unsubscribeQuestVotes() {
    // : implement unsubscribeQuestVotes
  }

  @override
  void unsubscribeSquadIsSubmitted() {
    // : implement unsubscribeSquadIsSubmitted
  }

  @override
  void unsubscribeSquadVotes() {
    // : implement unsubscribeSquadVotes
  }

  @override
  Future<void> updateMerlinKilled(bool merlinKilled) {
    // : implement updateMerlinKilled
    throw UnimplementedError();
  }

  @override
  Future<void> updateSquadIsApproved({bool isApproved = true}) {
    // : implement updateSquadIsApproved
    throw UnimplementedError();
  }

  @override
  Future<void> updateSquadIsSuccessfull({bool isSuccessfull = true}) {
    // : implement updateSquadIsSuccessfull
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
