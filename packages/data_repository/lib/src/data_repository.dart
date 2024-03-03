import 'dart:async';

import 'package:cache/cache.dart';
import 'package:data_repository/data_repository.dart';
import 'package:data_repository/models/courtier.dart';
import 'package:data_repository/src/api_repository/api_repository.dart';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_repository.dart';

/// Facade for classess communicating with api
class DataRepository implements IDataRepository {
  DataRepository({
    CacheClient? cacheClient,
  }) {
    final cache = DataCache(cacheClient ?? CacheClient());
    _apiRepository = ApiRepository(cache);
    _rtuRepository = RtuRepository(cache);
  }
  late ApiRepository _apiRepository;
  late RtuRepository _rtuRepository;

  //----------------------- info -----------------------
  @override
  Future<Room> getRoomById() async {
    try {
      return await _apiRepository.getRoomById();
    } on Exception catch (_) {
      // TODO logging
      rethrow;
    }
  }

  @override
  int get currentRoomId => _apiRepository.currentRoomId;

  //----------------------- matchup -----------------------
  @override
  Future<void> createAndJoinRoom() async {
    try {
      await _apiRepository.createAndJoinRoom();
      await _rtuRepository.connect();
    } on Exception catch (_) {
      _rtuRepository.dispose();
    }
  }

  @override
  Future<void> joinRoom({required int roomId}) async {
    try {
      await _apiRepository.joinRoom(roomId: roomId);
      await _rtuRepository.connect();
    } on Exception catch (_) {
      _rtuRepository.dispose();
    }
  }

  @override
  Future<void> setNickname({required String nick}) async {
    await _apiRepository.setNickname(nick: nick);
  }

  @override
  Future<void> addDummyPlayer({required String nick}) async {
    await _apiRepository.addDummyPlayer(nick: nick);
  }

  @override
  Stream<List<Player>> streamPlayersList() => _rtuRepository.playerStream;
  // TODO jak stream pusty to api call o info, albo najpirw dodawac do streama po api callu a potem subskryowac, albo na serwerze kolejnosc cos nie cos?
  @override
  void subscribePlayersList() => _rtuRepository.subscribePlayersList();
  @override
  void unsubscribePlayersList() => _rtuRepository.unsubscribePlayersList();

  @override
  Future<void> leaveRoom() async {
    await _apiRepository.leaveRoom();
  }

  @override
  Future<void> removePlayer({required int playerId}) async {
    await _apiRepository.removePlayer(removedPlayerId: playerId);
  }

  @override
  void handlePlayerRemoval({required void Function() handler}) {
    _rtuRepository.handlePlayerRemoval(handler);
  }

  @override
  Future<void> startGame({required RolesDef rolesDef}) async {
    await _apiRepository.startGame(rolesDef: rolesDef);
  }

//----------------------------------------------------------------------------

  @override
  Future<List<Player>> playersList() {
    // : implement playersList
    throw UnimplementedError();
  }

  @override
  Stream<Player> streamPlayer() {
    // : implement streamPlayer
    throw UnimplementedError();
  }

  @override
  Stream<Room> streamRoom() {
    // : implement streamRoom
    throw UnimplementedError();
  }

  @override
  void subscribeGameStartedWith({required void Function(bool p1) doLogic}) {
    //stopListeningPlayers()
    // : implement subscribeGameStartedWith
  }

  @override
  void unsubscribeGameStarted() {
    // : implement unsubscribeGameStarted
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

  // : implement currentCourtier
  @override
  Courtier get currentCourtier => throw UnimplementedError();

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
  // : implement membersCount
  Future<int> get membersCount => throw UnimplementedError();

  @override
  Future<void> nextSquad({required int questNumber}) {
    // : implement nextSquad
    throw UnimplementedError();
  }

  @override
  // : implement playersCount
  Future<int> get playersCount => throw UnimplementedError();

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
  Stream<String> streamCurrentSquadId() {
    // : implement streamCurrentSquadId
    throw UnimplementedError();
  }

  @override
  Stream<List<Member>> streamMembersList({required squadId}) {
    // : implement streamMembersList
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

  @override
  Future<List<Courtier>> courtiersList() {
    // TODO: implement courtiersList
    throw UnimplementedError();
  }
}
