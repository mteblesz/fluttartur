import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:data_repository/data_repository.dart';
import 'package:http/http.dart' as http;
import './api_config.dart';

class DataApiRepository implements IDataRepository {
  DataApiRepository({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  final CacheClient _cache;

  //----------------------- token -----------------------
  static const userCacheKey = '__user_cache_key__';

  String get _authToken {
    User user = _cache.read<User>(key: userCacheKey) ?? User.empty;
    return user.token ?? "";
  }

  Map<String, String> getHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken',
      };

  //----------------------- matchup -----------------------
  @override
  Future<void> createRoom() async {
    final uri = Uri.parse(ApiConfig.createRoomUrl());

    try {
      final response = await http.post(uri, headers: getHeaders());

      if (response.statusCode != 201) {
        throw CreateRoomFailure(response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  // TODO old stuff for backwards-compatibility during changes (to be removed)

  @override
  String currentSquadId = "";

  @override
  Future<void> addMember(
      {required int questNumber,
      required String playerId,
      required String nick}) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<void> addPlayer(
      {required String userId, required String nick, bool isLeader = false}) {
    // TODO: implement addPlayer
    throw UnimplementedError();
  }

  @override
  Future<void> assignCharacters(List<String> characters) {
    // TODO: implement assignCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> assignLeader(int leaderIndex) {
    // TODO: implement assignLeader
    throw UnimplementedError();
  }

  @override
  Future<void> assignSpecialCharacters(Map<String, Player> map) {
    // TODO: implement assignSpecialCharacters
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentPlayer
  Player get currentPlayer => throw UnimplementedError();

  @override
  // TODO: implement currentRoom
  Room get currentRoom => throw UnimplementedError();

  @override
  Future<List<Squad>> getApprovedSquads() {
    // TODO: implement getApprovedSquads
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getSpecialCharacters() {
    // TODO: implement getSpecialCharacters
    throw UnimplementedError();
  }

  @override
  Future<bool> isCurrentPlayerAMember() {
    // TODO: implement isCurrentPlayerAMember
    throw UnimplementedError();
  }

  @override
  Future<void> joinRoom({required String roomId}) {
    // TODO: implement joinRoom
    throw UnimplementedError();
  }

  @override
  Future<void> leaveRoom() {
    // TODO: implement leaveRoom
    throw UnimplementedError();
  }

  @override
  // TODO: implement membersCount
  Future<int> get membersCount => throw UnimplementedError();

  @override
  Future<void> nextLeader() {
    // TODO: implement nextLeader
    throw UnimplementedError();
  }

  @override
  Future<void> nextSquad({required int questNumber}) {
    // TODO: implement nextSquad
    throw UnimplementedError();
  }

  @override
  // TODO: implement playersCount
  Future<int> get playersCount => throw UnimplementedError();

  @override
  Future<List<Player>> playersList() {
    // TODO: implement playersList
    throw UnimplementedError();
  }

  @override
  Future<List<bool>> questVotesInfo(int questNumber) {
    // TODO: implement questVotesInfo
    throw UnimplementedError();
  }

  @override
  Future<void> refreshRoomCache() {
    // TODO: implement refreshRoomCache
    throw UnimplementedError();
  }

  @override
  Future<void> removeMember(
      {required int questNumber, required String memberId}) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<void> removePlayer({required String playerId}) {
    // TODO: implement removePlayer
    throw UnimplementedError();
  }

  @override
  Future<void> setSpecialCharacters(List<String> specialCharacters) {
    // TODO: implement setSpecialCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> startGame() {
    // TODO: implement startGame
    throw UnimplementedError();
  }

  @override
  Stream<String> streamCurrentSquadId() {
    // TODO: implement streamCurrentSquadId
    throw UnimplementedError();
  }

  @override
  Stream<List<Member>> streamMembersList({required squadId}) {
    // TODO: implement streamMembersList
    throw UnimplementedError();
  }

  @override
  Stream<bool?> streamMerlinKilled() {
    // TODO: implement streamMerlinKilled
    throw UnimplementedError();
  }

  @override
  Stream<Player> streamPlayer() {
    // TODO: implement streamPlayer
    throw UnimplementedError();
  }

  @override
  Stream<List<Player>> streamPlayersList() {
    // TODO: implement streamPlayersList
    throw UnimplementedError();
  }

  @override
  Stream<Room> streamRoom() {
    // TODO: implement streamRoom
    throw UnimplementedError();
  }

  @override
  Future<void> submitSquad() {
    // TODO: implement submitSquad
    throw UnimplementedError();
  }

  @override
  void subscribeCurrentSquadIdWith(
      {required void Function(String p1) doLogic}) {
    // TODO: implement subscribeCurrentSquadIdWith
  }

  @override
  void subscribeGameStartedWith({required void Function(bool p1) doLogic}) {
    // TODO: implement subscribeGameStartedWith
  }

  @override
  void subscribeQuestVotesWith(
      {required void Function(List<bool?> p1) doLogic}) {
    // TODO: implement subscribeQuestVotesWith
  }

  @override
  void subscribeSquadIsSubmittedWith(
      {String squadId = '', required void Function(Squad p1) doLogic}) {
    // TODO: implement subscribeSquadIsSubmittedWith
  }

  @override
  void subscribeSquadVotesWith(
      {required void Function(Map<String, bool> p1) doLogic}) {
    // TODO: implement subscribeSquadVotesWith
  }

  @override
  void unsubscribeCurrentSquadId() {
    // TODO: implement unsubscribeCurrentSquadId
  }

  @override
  void unsubscribeGameStarted() {
    // TODO: implement unsubscribeGameStarted
  }

  @override
  void unsubscribeQuestVotes() {
    // TODO: implement unsubscribeQuestVotes
  }

  @override
  void unsubscribeSquadIsSubmitted() {
    // TODO: implement unsubscribeSquadIsSubmitted
  }

  @override
  void unsubscribeSquadVotes() {
    // TODO: implement unsubscribeSquadVotes
  }

  @override
  Future<void> updateMerlinKilled(bool merlinKilled) {
    // TODO: implement updateMerlinKilled
    throw UnimplementedError();
  }

  @override
  Future<void> updateSquadIsApproved({bool isApproved = true}) {
    // TODO: implement updateSquadIsApproved
    throw UnimplementedError();
  }

  @override
  Future<void> updateSquadIsSuccessfull({bool isSuccessfull = true}) {
    // TODO: implement updateSquadIsSuccessfull
    throw UnimplementedError();
  }

  @override
  Future<void> voteQuest(bool vote) {
    // TODO: implement voteQuest
    throw UnimplementedError();
  }

  @override
  voteSquad(bool vote) {
    // TODO: implement voteSquad
    throw UnimplementedError();
  }
}
