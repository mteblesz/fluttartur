import 'package:data_repository/models/models.dart';

import 'player_info_dto.dart';

class RoomInfoDto {
  int roomId;
  String status;
  int? currentSquadId;
  List<PlayerInfoDto> players;

  RoomInfoDto({
    required this.roomId,
    required this.status,
    required this.currentSquadId,
    required this.players,
  });

  factory RoomInfoDto.fromJson(Map<String, dynamic> json) {
    return RoomInfoDto(
      roomId: json['roomId'],
      status: json['status'],
      currentSquadId: json['currentSquadId'],
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => PlayerInfoDto.fromJson(playerJson))
          .toList(),
    );
  }

  Room toRoom() {
    return Room(
      id: roomId.toString(),
      gameStarted: status == "Playing",
      currentSquadId: currentSquadId?.toString(),
    );
  }
}
