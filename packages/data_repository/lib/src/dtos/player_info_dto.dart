import 'package:data_repository/model/model.dart';

class PlayerInfoDto {
  PlayerInfoDto({
    required this.playerId,
    required this.nick,
    required this.team,
    required this.role,
  });

  int playerId;
  String nick;
  String? team;
  String? role;

  factory PlayerInfoDto.fromJson(Map<String, dynamic> json) {
    return PlayerInfoDto(
      playerId: json['playerId'],
      nick: json['nick'] ?? "id: ${json['playerId'].toString()}",
      team: json['team'],
      role: json['role'],
    );
  }

  Player toPlayer() {
    return Player(
      id: playerId.toString(),
      nick: nick,
    );
  }
}
