import 'dart:async';
import 'package:universal_io/io.dart';
import 'dart:convert';

import 'package:data_repository/data_repository.dart';
import 'package:data_repository/src/data_cache.dart';
import '../dtos/dtos.dart';
import 'api_config.dart';
import 'http_sender.dart';

part 'info_requests.dart';
part 'matchup_requests.dart';
part 'squad_requests.dart';
part 'vote_requests.dart';
part 'kill_requests.dart';

/// Facade for classess communicating with api
class ApiRepository {
  ApiRepository(this._cache);

  final DataCache _cache;

  Map<String, String> getAuthHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_cache.authToken}',
      };

  //----------------------- example request -----------------------
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

  // request methods in extensions segregated 'by-api controller'
}
