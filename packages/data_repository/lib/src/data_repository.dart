import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:data_repository/data_repository.dart';
import './api_config.dart';
import './http_sender.dart';

class CacheNullException implements Exception {
  const CacheNullException([this.message = 'The cache is unexpectedly null.']);
  final String message;
}

class DataRepository implements IDataRepository {
  DataRepository({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  final CacheClient _cache;

  //----------------------- token -----------------------
  static const _userCacheKey = '__user_cache_key__';

  String get _authToken {
    User user = _cache.read<User>(key: _userCacheKey) ?? User.empty;
    return user.token ?? "";
  }

  Map<String, String> getAuthHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken',
      };

  //----------------------- matchup -----------------------
  static const invalidId = -1;
  static const roomIdCacheKey = '__room_id_cache_key__';
  int get roomId {
    return _cache.read<int>(key: roomIdCacheKey) ?? invalidId;
  }

  @override
  Future<void> createRoom() async {
    try {
      final response = await HttpSender.post(
        Uri.parse(ApiConfig.createRoomUrl()),
        headers: getAuthHeaders(),
      );

      if (response.statusCode != 201) {
        throw CreateRoomFailure(response.statusCode);
      }
      final locationHeader = response.headers[HttpHeaders.locationHeader];
      String roomId = Uri.parse(locationHeader!).pathSegments.last;

      _cache.write(key: roomIdCacheKey, value: int.parse(roomId));
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<RoomInfoDto> getRoomById() async {
    try {
      final response = await HttpSender.get(
        Uri.parse(ApiConfig.getRoomByIdUrl(roomId)),
        headers: getAuthHeaders(),
      );
      if (response.statusCode != 200) {
        throw GetRoomByIdFailure(response.statusCode);
      }
      Map<String, dynamic> jsonBody = jsonDecode(response.body);

      return RoomInfoDto.fromJson(jsonBody);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> joinRoom({required String roomId}) {
    // : implement joinRoom
    throw UnimplementedError();
  }

  @override
  Future<void> leaveRoom() {
    // : implement leaveRoom
    throw UnimplementedError();
  }

  @override
  Future<void> addPlayer(
      {required String userId, required String nick, bool isLeader = false}) {
    // : implement addPlayer
    throw UnimplementedError();
  }

  @override
  Future<void> startGame() {
    // : implement startGame
    throw UnimplementedError();
  }

  @override
  Future<void> assignCharacters(List<String> characters) {
    // : implement assignCharacters
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getSpecialCharacters() {
    // : implement getSpecialCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> assignSpecialCharacters(Map<String, Player> map) {
    // : implement assignSpecialCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> setSpecialCharacters(List<String> specialCharacters) {
    // : implement setSpecialCharacters
    throw UnimplementedError();
  }

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
  Stream<List<Player>> streamPlayersList() {
    // : implement streamPlayersList
    throw UnimplementedError();
  }

  @override
  Stream<Room> streamRoom() {
    // : implement streamRoom
    throw UnimplementedError();
  }

  @override
  void subscribeGameStartedWith({required void Function(bool p1) doLogic}) {
    // : implement subscribeGameStartedWith
  }

  @override
  void unsubscribeGameStarted() {
    // : implement unsubscribeGameStarted
  }

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
  Future<void> assignLeader(int leaderIndex) {
    // : implement assignLeader
    throw UnimplementedError();
  }

  @override
  // : implement currentPlayer
  Player get currentPlayer => throw UnimplementedError();

  @override
  // : implement currentRoom
  Room get currentRoom => throw UnimplementedError();

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
  Future<void> nextLeader() {
    // : implement nextLeader
    throw UnimplementedError();
  }

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
  Future<void> removePlayer({required String playerId}) {
    // : implement removePlayer
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
}
