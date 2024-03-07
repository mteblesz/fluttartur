import 'dart:async';
import 'package:universal_io/io.dart';
import 'dart:convert';

import 'package:data_repository/data_repository.dart';
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
  ApiRepository({required this.getAuthToken});

  final Function() getAuthToken;

  Map<String, String> getAuthHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getAuthToken()}',
      };

  //----------------------- example request -----------------------
  Future<Room> getRoomById(int roomId) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getRoomByIdUrl(roomId)),
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
