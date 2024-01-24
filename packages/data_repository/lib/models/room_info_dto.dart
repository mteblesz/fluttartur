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
}

class PlayerInfoDto {
  int playerId;
  String nick;
  String team;
  String role;

  PlayerInfoDto({
    required this.playerId,
    required this.nick,
    required this.team,
    required this.role,
  });

  factory PlayerInfoDto.fromJson(Map<String, dynamic> json) {
    return PlayerInfoDto(
      playerId: json['playerId'],
      nick: json['nick'],
      team: json['team'],
      role: json['role'],
    );
  }
}
