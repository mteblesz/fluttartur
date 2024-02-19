import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:data_repository/data_repository.dart';
import 'package:data_repository/src/data_cache.dart';
import '../../dtos/dtos.dart';
import 'api_config.dart';
import 'http_sender.dart';

class CacheNullException implements Exception {
  const CacheNullException([this.message = 'The cache is unexpectedly null.']);
  final String message;
}

/// Facade for classess communicating with api
class ApiRepository {
  ApiRepository(this._cache);

  final DataCache _cache;

  Map<String, String> getAuthHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_cache.authToken}',
      };

  //----------------------- info -----------------------
  Future<Room> getRoomById() async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getRoomByIdUrl(_cache.currentRoomId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(response.statusCode, response.body);
    }
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return RoomInfoDto.fromJson(jsonBody).toRoom();
  }

  //----------------------- matchup -----------------------
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

    _cache.currentRoomId = roomId;
    return roomId;
  }

  Future<void> joinRoom({required int roomId}) async {
    final response = await HttpSender.post(
      Uri.parse(ApiConfig.joinRoomUrl(roomId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 201) {
      throw JoinRoomFailure(response.statusCode, response.body);
    }
    final locationHeader = response.headers[HttpHeaders.locationHeader];
    final playerId = int.parse(Uri.parse(locationHeader!).pathSegments.last);

    _cache.currentPlayerId = playerId;
  }

  Future<void> setNickname({required String nick}) async {
    final playerDto = NicknameSetDto(
      playerId: _cache.currentPlayerId,
      nick: nick,
    );
    final response = await HttpSender.patch(
      Uri.parse(ApiConfig.setNicknameUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(playerDto.toJson()),
    );

    if (response.statusCode != 204) {
      throw SetNicknameFailure(response.statusCode, response.body);
    }
  }

  Future<void> removePlayer({required int playerId}) async {
    final response = await HttpSender.patch(
      Uri.parse(ApiConfig.removePlayerUrl(playerId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 204) {
      throw RemovePlayerFailure(response.statusCode, response.body);
    }
  }

  Future<void> leaveRoom() async {
    await removePlayer(playerId: _cache.currentPlayerId);
  }
}
