import 'package:data_repository/model/model.dart';

import './utils.dart';

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

  Player toPLayer() {
    return Player(
      id: playerId.toString(),
      nick: nick,
    );
  }

  Courtier toCourtier() {
    if (team == null || role == null) {
      return Courtier.empty;
    }

    return Courtier(
      id: playerId.toString(),
      nick: nick,
      team: Team.values.byName(team!.toLowerFirst()),
      role: Role.values.byName(role!.toLowerFirst()),
    );
  }
}
