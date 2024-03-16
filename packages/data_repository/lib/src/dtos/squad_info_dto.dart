import '../../model/model.dart';
import 'player_info_dto.dart';

class SquadInfoDto {
  int squadId;
  int questNumber;
  int rejectionsLeftToEvilWin;
  int requiredPlayersNumber;
  SquadStatus status;
  PlayerInfoDto leader;
  List<PlayerInfoDto> members;

  SquadInfoDto({
    required this.squadId,
    required this.questNumber,
    required this.rejectionsLeftToEvilWin,
    required this.requiredPlayersNumber,
    required this.status,
    required this.leader,
    required this.members,
  });

  factory SquadInfoDto.fromJson(Map<String, dynamic> json) {
    return SquadInfoDto(
      squadId: json['squadId'],
      questNumber: json['questNumber'],
      rejectionsLeftToEvilWin: json['rejectionsLeftToEvilWin'],
      requiredPlayersNumber: json['requiredPlayersNumber'],
      status: SquadStatus.values[json['status']],
      leader: PlayerInfoDto.fromJson(json['leader']),
      members: (json['members'] as List)
          .map((e) => PlayerInfoDto.fromJson(e))
          .toList(),
    );
  }

  Squad toSquad() {
    return Squad(
      squadId: squadId,
      questNumber: questNumber,
      rejectionsLeftToEvilWin: rejectionsLeftToEvilWin,
      requiredPlayersNumber: requiredPlayersNumber,
      status: status,
      leader: leader.toPlayer(),
      members: members.map((member) => member.toPlayer()).toList(),
    );
  }
}
